<template>
  <div class="column">
    <div class="box">
      <router-view name="charts" :user-id="this.userId" />
    </div>

    <div class="box">
      <div class="columns is-gapless is-mobile">お気に入り</div>
      <router-view name="favorite-list" :user-id="this.userId" />
      <div class="columns is-gapless is-mobile">
        <router-link to="/list" class="button is-small is-primary">
          <span class="name">登録・編集</span>
        </router-link>
      </div>
    </div>

    <div class="box">
      <router-view name="registration-form" :user-id="this.userId" />
    </div>
  </div>
</template>

<script>
export default {
  props: ['userId']
}
</script>
