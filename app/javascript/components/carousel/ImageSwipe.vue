<template>
  <div class="image-swipe">
    <div class="image-swipe__body" v-bind:style="{width: itemWidth + 'px'}">
      <v-touch @swipeleft="onSwipeLeft" @swiperight="onSwipeRight" :swipe-options="{direction: 'horizontal'}">
        <transition-group name="image-swipe__list" tag="div" class="image-swipe__container">
          <figure v-for="index in images" v-bind:key="index" v-bind:style="{width: itemWidth + 'px'}" class="image-swipe__item">
            <img :src="index" class="image-swipe__item__image">
          </figure>
          <!-- <figure v-for="index in [currentIndex]" v-bind:key="index" v-bind:style="{width: itemWidth + 'px'}" class="image-swipe__item">
            <img :src="images[Math.abs(currentIndex) % images.length]" class="image-swipe__item__image">
          </figure> -->
        </transition-group>
      </v-touch>
    </div>
  </div>
</template>

<!-- <div class="slider">
    <h1 class="slider__heading__title">スライダー</h1>
    <div class="slider__content">
        <ul class="slider__content__lists cf">
            <li class="slider__content__item">
                <a href="#">
                    <p class="slider__content__image"><img src="" width="235" height="135" alt=""></p>
                    <p class="slider__content__detail-title">コンテンツ１</p>
                </a>
            </li>
            <li class="slider__content__item">
                <a href="#">
                    <p class="slider__content__image"><img src="" width="235" height="135" alt=""></p>
                    <p class="slider__content__detail-title">コンテンツ２</p>
                </a>
            </li>
            <li class="slider__content__item">
                <a href="#">
                    <p class="slider__content__image"><img src="" width="235" height="135" alt=""></p>
                    <p class="slider__content__detail-title">コンテンツ３</p>
                </a>
            </li>
        </ul>
    </div>
</div> -->

<script>
  export default {
    props: {
      images: Array,
      itemWidth: 0
    },
    data: function() {
      return {
        currentIndex: 0,
      }
    },
    methods: {
      onSwipeLeft: function() {
        this.displayNext()
      },

      onSwipeRight: function() {
        this.displayPrevious()
      },
      wholeWidth: function() {
        return this.itemWidth * this.images.length
      },
      margin: function() {
        return this.currentIndex * -1 * this.itemWidth
      },
      imageRange: function() {
        return Array.from({length: this.images.length}, (k, v) => v);
      },
      displayPrevious: function() {
        if(this.currentIndex > 0) {
          this.currentIndex--
        }
      },
       displayNext: function() {
        if(this.currentIndex < this.images.length - 1) {
          this.currentIndex++
        }
      }
    }
  }
</script>

<style lang="scss">

.slider {
    margin: 30px;
    padding: 20px 20px 0;
    width: 320px;//コンテンツの幅を指定、はみ出た分は非表示
    background: #fff;
    -webkit-box-shadow: 0 0 3px #ccc;
       -moz-box-shadow: 0 0 3px #ccc;
            box-shadow: 0 0 3px #ccc;
}
.slider__heading__title {
    margin-bottom: 10px;
    font-weight: bold;
    font-size: 15px;
}
.slider__content {
    position: relative;
    overflow: scroll;
    -webkit-overflow-scrolling: touch;//慣性スクロール
    transform: translateZ(0);//GPUアクセラレーションを有効にする
}

.slider__content__lists {
    margin-bottom: 20px;
    width: 825px;//slider__content__itemの幅
}

.slider__content__item {
    position: relative;
    float: left;
    margin-right: 10px;
    padding: 15px;
    width: 235px;
    background: #f7f7f7;
}
.slider__content__image {
    margin: 0 auto 10px;
    width: 235px;
}
.slider__content__detail-title {
    font-size: 12px;
}

.image-swipe {
  margin: 30px;
  padding: 20px 20px 0;
  width: 320px;//コンテンツの幅を指定、はみ出た分は非表示
  background: #fff;
  -webkit-box-shadow: 0 0 3px #ccc;
     -moz-box-shadow: 0 0 3px #ccc;
          box-shadow: 0 0 3px #ccc;

    &__body {
      position: relative;
      overflow: scroll;
      -webkit-overflow-scrolling: touch;//慣性スクロール
      transform: translateZ(0);//GPUアクセラレーションを有効にする
        // overflow: hidden;
        // margin: 0px auto;
    }
    &__container {
      margin-bottom: 20px;
      width: 2700px;//slider__content__itemの幅
        // height: 580px;
        // transition: all 500ms linear 0s;
    }
    &__item {
      position: relative;
      float: left;
      margin-right: 10px;
      padding: 15px;
      width: 235px;
      background: #f7f7f7;
      // margin: 0px 0px;
      // display: inline-block;
    }
}
</style>
