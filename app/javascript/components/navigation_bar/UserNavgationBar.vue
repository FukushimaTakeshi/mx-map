<template>
  <div class="columns">

    <div class="column is-2 hero is-fullheight is-hidden-mobile has-text-left">
      <aside class="menu">
        <ul class="menu-list">
          <li>
            <router-link to="/" class="item active">
              <span class="icon">
                <i class="fa fa-inbox"></i>
              </span>
              <span class="name">ユーザーTOP</span>
            </router-link>
          </li>
        </ul>
        <ul class="menu-list">
          <li>
            <router-link to="/list" class="item">
              <span class="icon">
                <i class="fa fa-star"></i>
              </span>
              <span class="name">お気に入り登録</span>
            </router-link>
          </li>
        </ul>
      </aside>
    </div>
    
    <router-view :user-id="this.userId" />
    <router-view name="list" />

  </div>
</template>

<script>
  export default {
    props: [
      'userId'
    ]
  }
</script>
