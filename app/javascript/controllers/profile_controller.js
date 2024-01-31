import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile"
export default class extends Controller {
  static targets = ["input"]

    preview() {
      let input = this.inputTarget;
      let files = input.files;
    
      if (files.length > 0) {
        let fileSizeInMb = files[0].size / (1024 * 1024); 
    
        if (fileSizeInMb < 0.5) {
          let imgLoc = document.getElementById("Img");
          let reader = new FileReader();
    
          reader.onload = function() {
            let image = document.createElement("img");
            imgLoc.appendChild(image);
            image.style.height = '150px';
            image.src = reader.result;
          }
    
          reader.readAsDataURL(files[0]);
        } else {
          alert('File size is too large. Please choose a file smaller than 0.5MB.');
          input.value = "";
        }
      }
    }
}
