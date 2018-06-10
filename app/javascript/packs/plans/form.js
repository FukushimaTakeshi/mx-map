// import Vue from 'vue/dist/vue.esm'
import Vue from 'vue'
import Plan from '../../components/plans/plans.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#map',
    components: { Plan }
  })

  console.log(app)
})
