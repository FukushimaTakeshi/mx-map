<template>
  <div class="column">
    <div class="box">
      <h1 class="title is-6">コースを選択する</h1>
      <div class="columns is-centered has-text-left">
        <div class="column is-two-thirds">
          <article v-for="region in regionList" :key="region.id" class="message is-primary" id="message">
            <div @click="setArea(region.id)" class="message-header">
              <p>{{ region.name }}</p>
            </div>

            <transition name="">
              <div v-if="selectedArea === region.id" class="message-body">
                <div class="columns is-mobile is-multiline is-centered">
                  <div v-for="prefecture in region.prefectures" :key="prefecture.id" class="column is-four-fifths prefecture-post">
                    <p @click="openCircuitsModal(prefecture.id)">{{ prefecture.name }}</p>
                  </div>
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
      this.$root.eventBus.$emit('open-circuits-modal', prefectureId)
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
#message {
  margin-bottom: 0.5rem;
}

div.prefecture-post {
  cursor: pointer;
  padding-bottom: 0.3rem;
  border-bottom: 1px solid #E6EAEE;
}
div.prefecture-post:last-child {
  border-bottom: none;
}
</style>
