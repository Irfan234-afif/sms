<template>
  <div class="main-container">
    <div class="editor-container editor-container_classic-editor" ref="editorContainerElement">
      <div class="editor-container__editor">
        <div ref="editorElement">
          <ckeditor
            v-if="editor && config"
            :model-value="modelValue"
            :editor="editor"
            :config="config"
            @update:model-value="updateValue"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, ref, onMounted } from 'vue';
import { Ckeditor } from '@ckeditor/ckeditor5-vue';
import {
  ClassicEditor,
  Autoformat,
  AutoImage,
  Autosave,
  BlockQuote,
  Bold,
  CloudServices,
  Essentials,
  Heading,
  ImageBlock,
  ImageCaption,
  ImageInline,
  ImageInsertViaUrl,
  ImageResize,
  ImageStyle,
  ImageTextAlternative,
  ImageToolbar,
  ImageUpload,
  Indent,
  IndentBlock,
  Italic,
  Link,
  LinkImage,
  List,
  ListProperties,
  Paragraph,
  Table,
  TableCaption,
  TableCellProperties,
  TableColumnResize,
  TableProperties,
  TableToolbar,
  TextTransformation,
  TodoList,
  Underline,
  Font,
} from 'ckeditor5';
import 'ckeditor5/ckeditor5.css';

// eslint-disable-next-line no-unused-vars
const props = defineProps({
  modelValue: String,
});

const emit = defineEmits(['update:modelValue']);

const LICENSE_KEY = 'GPL';
const isLayoutReady = ref(false);
const editor = ClassicEditor;

const config = computed(() => {
  if (!isLayoutReady.value) {
    return null;
  }

  return {
    toolbar: {
      items: [
        'undo',
        'redo',
        '|',
        'heading',
        'fontFamily',
        'fontSize',
        'fontColor',
        'fontBackgroundColor',
        '|',
        'bold',
        'italic',
        'underline',
        'highlight',
        'removeFormat',
        '|',
        'alignment',
        'indent',
        'outdent',
        'numberedList',
        'bulletedList',
        '|',
        'link',
        'blockQuote',
        'specialCharacters',
        'horizontalLine',
        '|',
        'code',
        'codeBlock',
        '|',
        'imageUpload',
        '|',
        'mediaEmbed',
        '|',
        'insertTable',
      ],
      shouldNotGroupWhenFull: false,
    },
    plugins: [
      Font,
      Autoformat,
      AutoImage,
      Autosave,
      BlockQuote,
      Bold,
      CloudServices,
      Essentials,
      Heading,
      ImageBlock,
      ImageCaption,
      ImageInline,
      ImageInsertViaUrl,
      ImageResize,
      ImageStyle,
      ImageTextAlternative,
      ImageToolbar,
      ImageUpload,
      Indent,
      IndentBlock,
      Italic,
      Link,
      LinkImage,
      List,
      ListProperties,
      Paragraph,
      Table,
      TableCaption,
      TableCellProperties,
      TableColumnResize,
      TableProperties,
      TableToolbar,
      TextTransformation,
      TodoList,
      Underline,
    ],
    extraPlugins: [Base64UploadAdapter],
    heading: {
      options: [
        { model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
        { model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' },
        { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
        { model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' },
        { model: 'heading4', view: 'h4', title: 'Heading 4', class: 'ck-heading_heading4' },
        { model: 'heading5', view: 'h5', title: 'Heading 5', class: 'ck-heading_heading5' },
        { model: 'heading6', view: 'h6', title: 'Heading 6', class: 'ck-heading_heading6' },
      ],
    },
    image: {
      toolbar: [
        'toggleImageCaption',
        'imageTextAlternative',
        '|',
        'imageStyle:inline',
        'imageStyle:wrapText',
        'imageStyle:breakText',
        '|',
        'resizeImage',
      ],
    },
    placeholder: 'Ketik atau tempel konten di sini...',
    table: {
      contentToolbar: ['tableColumn', 'tableRow', 'mergeTableCells', 'tableProperties', 'tableCellProperties'],
    },
    licenseKey: LICENSE_KEY,
  };
});

function Base64UploadAdapter(editor) {
  editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
    return new UploadAdapter(loader);
  };
}

class UploadAdapter {
  constructor(loader) {
    this.loader = loader;
  }

  upload() {
    return this.loader.file.then((file) => {
      return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => resolve({ default: reader.result });
        reader.onerror = (error) => reject(error);
        reader.readAsDataURL(file);
      });
    });
  }
}

// Fungsi untuk mengupdate nilai yang dikirim ke parent
const updateValue = (value) => {
  emit('update:modelValue', value);
};

onMounted(() => {
  isLayoutReady.value = true;
});
</script>

<style>
.ck-powered-by {
  display: none !important;
}
</style>
