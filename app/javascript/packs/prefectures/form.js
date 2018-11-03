import 'babel-polyfill'
import Vue from 'vue'

import Plan from '../../components/plans/Plan.vue'
import Carousel from '../../components/carousel/Carousel.vue'
import FavoriteIcon from '../../components/off_road_circuits/FavoriteIcon.vue'

import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('form')) {
    new Vue({
      el: '#form',
      components: {
        'plan': Plan,
        'carousel': Carousel,
        'favorite-icon': FavoriteIcon
      }
    })
  }
})
