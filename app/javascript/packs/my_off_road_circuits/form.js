import 'babel-polyfill'
import Vue from 'vue'

import List from '../../components/off_road_circuits/List.vue'

import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('form')) {
    new Vue({
      el: '#form2',
      components: {
        'list': List
      }
    })
  }
})
