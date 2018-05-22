import Vue from 'vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: "#prefectures",
    data: {
      selectedArea: ""
    },
    methods: {
      setArea: function(index) {
        if (this.selectedArea == index) {
          this.selectedArea = ""
        } else {
          this.selectedArea = index
        }
      }
    }
  })
  console.log(app)
})
