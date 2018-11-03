<template>
  <div class="column">
    <div class="box">
      
      <div class="columns is-centered has-text-left">
      <div class="column is-two-thirds">
        <article v-for="region in regionList" :key="region.id" class="message is-primary" id="message">
          <div @click="setArea(region.id)" class="message-header">
            <p>{{ region.name }}</p>
          </div>
          
          <transition name="">
            <div v-if="selectedArea === region.id" class="message-body">
              <div v-for="prefecture in region.prefectures" :key="prefecture.id" class="subtitle is-6 is-marginless">
                <p @click="openCircuitsModal(prefecture.id)">{{ prefecture.name }}</p>
              </div>
            </div>
          </transition>
        </article>
      </div>
      </div>

    <ModalList :userId="userId" />
    </div>
  </div>
</template>

<script>
import ModalList from './ModalList.vue'
import ModalEvent from '../../packs/router/index.js'

import axios from 'axios'

export default {
  components: { ModalList },
  props: ['userId'],
  data() {
    return {
      regionList: [],
      OffRoadCircuitList: [],
      selectedArea: null
    }
  },
  mounted: async function() {
    const res = await axios.get('/api/regions')
    if (res.status !== 200) {
      process.exit()
    }
    this.regionList = res.data
  },
  methods: {
    openCircuitsModal: function(prefectureId) {
      ModalEvent.$emit('open-circuits-modal', prefectureId)
    },
    setArea: function(index) {
      if (this.selectedArea == index) {
        this.selectedArea = ""
      } else {
        this.selectedArea = index
      }
    }
  }
}
</script>

<style>
.events-card .card-table {
  max-height: 250px;
  overflow-y: scroll;
}
#message {
  margin-bottom: 0.5rem;
}
</style>
