<template>
  <div>
    <off-road-circuit-list></off-road-circuit-list>
  </div>
</template>

<script>
  import OffRoadCircuitList from '../off_road_circuits/OffRoadCircuitList.vue'

  export default {
    components: { OffRoadCircuitList },
    data() {
      return {
        agent: Object,
        meta: Object,
        isTopicsPath: false,
        isSmartPhone: false
      }
    }
  }
</script>
