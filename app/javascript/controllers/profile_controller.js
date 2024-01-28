import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile"
export default class extends Controller {
  initialize() {
    this.fileInput = this.element.querySelector('input[type="file"]');
    this.imagePreview = this.element.querySelector('.image-preview');

    // Attach event listener for file input change
    this.fileInput.addEventListener('change', this.handleFileChange.bind(this));
  }

  validateFileSize(event) {
    const maxFileSize = 0.5 * 1024 * 1024;

    const fileInput = event.currentTarget;
    const files = fileInput.files;

    if (files.length > 0 && files[0].size > maxFileSize) {
      alert('File size must be less than 5MB.');
      fileInput.value = '';
    }
  }

  displayImagePreview(file) {
    const reader = new FileReader();

    reader.onload = (e) => {
      this.imagePreview.src = e.target.result;
    };

    reader.readAsDataURL(file);
  }

  clearFileInput() {
    this.fileInput.value = ''; // Clear the file input
    this.imagePreview.src = ''; // Clear the image preview
  }
}
