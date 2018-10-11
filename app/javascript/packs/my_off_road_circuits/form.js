import 'babel-polyfill'
import Vue from 'vue'

import BarApp from '../../components/charts/BarApp.vue'

import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('form')) {
    new Vue({
      el: '#form',
      components: {
        'bar-app': BarApp
      }
    })
  }
})
