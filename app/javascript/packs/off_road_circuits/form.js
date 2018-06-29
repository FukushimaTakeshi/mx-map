import 'babel-polyfill'
import Vue from 'vue'

import ImageSwipe from '../../components/carousel/ImageSwipe.vue'

import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)


import VueTouch from 'vue-touch'
Vue.use(VueTouch, {name: 'v-touch'})

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('form')) {
    new Vue({
      el: '#form',
      components: {
        'image-swipe': ImageSwipe
      }
    })
  }
})
