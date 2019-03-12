<template>
  <span>
    <div class="columns is-gapless is-mobile">練習記録リスト</div>
    <div v-for="(practiceRecode, index) in practiceRecodes" :key="index" class="media">
      <div class="media-left">
        <figure class="image is-96x96">
          <img :src="practiceRecode.photo_url || 'https://placehold.it/100/?text=no-image'" alt="Image">
        </figure>
      </div>
      <div class="media-content">
        <div class="content">
          <p>
            <strong>{{ practiceRecode.practice_date }}</strong>
            <small>{{ practiceRecode.off_road_circuit_name }}</small>
            <br>
            <span style="white-space: pre-wrap;" v-text="practiceRecode.comment"></span>
          </p>
        </div>
      </div>
    </div>
    <div v-show="practiceRecodes.length === 0" class="notification">
      まだ記録されてません。
    </div>
  </span>
</template>

<script>
export default {
  props: ['userId'],
  computed: {
    practiceRecodes() {
      return this.$store.state.practiceRecodes
    }
  }
}
</script>
