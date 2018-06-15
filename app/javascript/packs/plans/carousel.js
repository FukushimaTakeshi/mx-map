import Vue from 'vue'
import Carousel from '../../components/carousel/Carousel.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el:'#form',
    data:{
      dropImageUrls: []
    },
    components:{
      'carousel':Carousel
    }
  })
})
