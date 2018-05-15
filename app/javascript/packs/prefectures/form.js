import Vue from 'vue'
import router from '../router'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    el: "#prefectures",
    data: {
      name: 'Vue.js'
    },
    methods: {
      expand: function(message) {
        console.log(message)
      }
    }
  })
  console.log(app)
})
