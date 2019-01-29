<template>
  <transition name="modal">
    <div class="column is-9 is-offset-3">
    <div v-show="isOpen" class="modal is-active">
      <div class="modal-background" @click.self="close()"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="mdi-18px has-text-link">
            <i class="fas fa-heart"></i>
            {{ plans.length }}人
          </p>
          <p class="modal-card-title">{{ date }}</p>
          <button @click.self="close()" class="delete" aria-label="close"></button>
        </header>
        <section class="modal-card-body">
          <span v-if="!plans.length" v-show="!loading">まだ予定がありません(´・ω・｀)</span>
          <article v-for="plan in plans" v-show="!loading" class="post">
            <div class="media">
              <div class="media-left">
                <p class="image is-32x32">
                  <img :src="plan.users.avatar">
                </p>
              </div>
              <div class="media-content">
                <div class="content">
                  <p>
                    <a v-if="plan.users.id !== null" :href="'/users/' + plan.users.id">{{ plan.users.username }}</a>
                    <a v-else>{{ plan.users.username }}</a>
                  </p>
                </div>
              </div>
            </div>
          </article>
          <!-- loading component -->
          <Loading v-if="loading"></Loading>
        </section>
        <footer class="modal-card-foot">
          <button v-if="!isAlreadyPlan" :disabled="loading" class="button is-success" @click.self="createAttendance()">走りに行く！</button>
          <button v-else :disabled="loading" class="button is-warning" @click.self="deleteAttendance()">やっぱやめとく！</button>
        </footer>
      </div>
    </div>
    </div>
  </transition>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

import ModalEvent from '../../packs/off_road_circuits/form.js'
import Loading from '../load/LoadContent.vue'

export default {
  components: { Loading },
  name: 'App',
  props: [
    'circuitId',
    'userId'
  ],
  data() {
    return {
      date: "",
      plan: 0,
      plans: [],
      isAlreadyPlan: false,
      isOpen: false,
      loading: false
    }
  },
  mounted: function() {
    ModalEvent.$on('open-modal', this.open)
  },
  methods: {
    open: function(date) {
      this.isOpen = true
      this.date = date
      this.loading = true
      this.isAlreadyPlan = false
      this.setPlans()
    },
    close: function() {
      this.isOpen = false
    },
    createAttendance: async function() {
      this.loading = true
      const res = await axios.post(`/api/plans/`, {date: this.date, off_road_circuit_id: this.circuitId })
      if (res.status !== 201) {
        process.exit()
      }
      this.setPlans()
    },
    deleteAttendance: async function(date, index) {
      this.loading = true
      const res = await axios.delete(`/api/plans/${this.planId}`)
      if (res.status !== 200) {
        process.exit()
      }
      this.setPlans()
    },
    setPlans: function() {
      getAttendance(this.circuitId, this.date).then(result => {
        this.plans = result.plans

        const singnedInUserPlan = result.plans.find((plan) => {
          return (this.userId === plan['user_id'])
        })

        if (singnedInUserPlan || result.id ) {
          this.isAlreadyPlan = true
          this.planId = (result.id || singnedInUserPlan['id'])
        } else {
          this.isAlreadyPlan = false
        }
        this.loading = false
      })
    }
  }
}

async function getAttendance(circuitId, date) {
  const res = await axios.get(`/api/plans/?off_road_circuit_id=${circuitId}&date=${date}`)
  if (res.status !== 200) {
    process.exit()
  }
  return res.data
}
</script>

<style lang="scss">
article.post {
  margin: 1rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #E6EAEE;
}
article.post:last-child {
  padding-bottom: 0;
  border-bottom: none;
}
</style>
