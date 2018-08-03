import 'babel-polyfill'
import Vue from 'vue'

import App from '../../components/charts/App.vue'

import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('form')) {
    new Vue({
      el: '#form',
      components: {
        'app': App
      }
    })
  }
})
