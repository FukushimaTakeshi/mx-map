import 'babel-polyfill'
import Vue from 'vue'

import Charts from '../../components/charts/Charts.vue'

import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

import ModalEvent from '../EventBus.js'
export default ModalEvent

import calender from '../../mixin/calendar.js'
Vue.mixin(calender)

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('form')) {
    new Vue({
      el: '#form',
      components: {
        Charts
      }
    })
  }
})
