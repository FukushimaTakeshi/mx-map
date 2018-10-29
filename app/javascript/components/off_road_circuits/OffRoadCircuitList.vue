<template>
  <div>
    <div v-for="region in regionList" :key="region.id">
      {{ region.name }}
      <div v-for="prefecture in region.prefectures" :key="prefecture.id">
        {{ prefecture.name }}
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    data() {
      return {
        regionList: []
      }
    },
    mounted: async function() {
      const res = await axios.get('/api/regions')
      if (res.status !== 200) {
        process.exit()
      }
      this.regionList = res.data
    }
  }
</script>
