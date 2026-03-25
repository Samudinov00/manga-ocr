from .base import *
import os
from datetime import datetime


@register_translator('Text Export')
class TextExportTranslator(BaseTranslator):
    """
    Saves all source text to a single .txt file for manual/artistic translation.
    Returns original text as placeholder so the pipeline continues without errors.
    """

    concate_text = False
    params: Dict = {
        'output_file': 'translation_export.txt',
        'delay': 0.0,
    }

    def _setup_translator(self):
        for lang in [
            '日本語', 'English', 'Brazilian Portuguese', 'Português',
            '简体中文', '繁體中文', '한국어', 'Tiếng Việt', 'Français',
            'Deutsch', 'Italiano', 'Español', 'русский язык', 'Türk dili',
            'Polski', 'Nederlands', 'čeština', 'magyar nyelv',
        ]:
            self.lang_map[lang] = lang

    def _translate(self, src_list: List[str]) -> List[str]:
        output_file = self.params.get('output_file', 'translation_export.txt')

        # If path is not absolute, save next to the project
        if not os.path.isabs(output_file):
            output_file = os.path.join(os.getcwd(), output_file)

        with open(output_file, 'a', encoding='utf-8') as f:
            for text in src_list:
                if text and text.strip():
                    f.write(text.strip())
                    f.write('\n---\n')

        # Return original text as placeholder
        return list(src_list)
