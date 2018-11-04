import Vue from 'vue'
import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
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
})
