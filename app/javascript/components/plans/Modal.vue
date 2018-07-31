<template>
  <transition name="modal">
    <div class="column is-9 is-offset-3">
    <div v-show="isOpen" class="modal is-active">
      <div class="modal-background" @click.self="close()"></div>
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="mdi-18px has-text-link">
            <i class="fas fa-heart"></i>
            {{ plan }}人
          </p>
          <p class="modal-card-title">{{ date }}</p>
          <button @click.self="close()" class="delete" aria-label="close"></button>
        </header>
        <section class="modal-card-body">
          <span v-if="!users.length" v-show="!loading">まだ予定がありません(´・ω・｀)</span>
					<article v-for="user in users" v-show="!loading" class="post">
						<div class="media">
							<div class="media-left">
								<p class="image is-32x32">
									<img :src="user.avatar">
								</p>
							</div>
							<div class="media-content">
								<div class="content">
									<p>
                    <a v-if="user.id !== null" :href="'/users/' + user.id">{{ user.username }}</a>
                    <a v-else>{{ user.username }}</a>
									</p>
								</div>
							</div>
							<div class="media-right">
								<span class="has-text-grey-light"><i class="fa fa-comments"></i> 1</span>
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
    'circuitId'
  ],
  data() {
    return {
      date: "",
      plan: 0,
      users: [],
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
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.setPlans()
    },
    deleteAttendance: async function(date, index) {
      this.loading = true
      const res = await axios.delete(`/api/plans/${this.planId}`)
      if (res.status !== 200) {
        console.log("Error!!")
        process.exit()
      }
      this.setPlans()
    },
    setPlans: function() {
      getAttendance(this.circuitId, this.date).then(result => {
        setTimeout(() => {
          this.plan = result.plans.length
          this.users = result.users
          if (result.id == null) {
            this.isAlreadyPlan = false
          } else {
            this.isAlreadyPlan = true
            this.planId = result.id
          }
          this.loading = false
        }, 1000)
      })
    }
  }
}

async function getAttendance(circuitId, date) {
  const res = await axios.get(`/api/plans/?off_road_circuit_id=${circuitId}&date=${date}`)
  if (res.status !== 200) {
    console.log("Error!!")
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
