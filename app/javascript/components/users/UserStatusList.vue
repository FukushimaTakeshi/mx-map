<template>
  <span>
    <div class="box">
      <router-view name="charts" :user-id="this.userId" />
    </div>

    <div class="box">
      <div class="columns is-gapless is-multiline is-mobile">お気に入り</div>
      <router-view name="favorite-list" :user-id="this.userId" />
    </div>
  </span>
</template>

<script>
  export default {
    props: [
      'userId'
    ],
    data() {
      return {
        agent: Object,
        meta: Object,
        isTopicsPath: false,
        isSmartPhone: false
      }
    },
    methods: {
      hoge: function() {
        console.log(this.userId)
      }
    }
  }
</script>
