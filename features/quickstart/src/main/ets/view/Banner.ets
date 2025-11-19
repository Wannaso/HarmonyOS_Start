import {BannerClass} from '../model/BannerClass';
import { bufferToString } from '../util/BufferUtil';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BreakpointType, BreakpointTypeEnum } from 'utils';

const TAG = 'Banner';


@Component
export struct Banner {
  @State bannerList: BannerClass[] = [];
  @Consume('articlePathStack') articlePathStack: NavPathStack;
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointTypeEnum.MD;
  aboutToAppear(): void {
    console.log("Banner aboutToAppear")
    this.getBannerDataFromJSON();
  }



  getBannerDataFromJSON() {
    this.getUIContext().getHostContext()?.resourceManager.getRawFileContent('BannerData.json').catch(() => {
      hilog.error(0x0000, TAG, 'getBannerDataFromJSON failed');
    }).then(value => {
      this.bannerList = JSON.parse(bufferToString(value as Uint8Array)) as BannerClass[];
    });
  }

  build() {
    Swiper() {
      ForEach(this.bannerList, (item: BannerClass, index: number) => {
        Image($r(item.imageSrc))
          .objectFit(ImageFit.Contain)
          .width('100%')
          .padding({ top: 11, left: 16, right: 16 })
          .borderRadius(16)
          .onClick(() => {
            this.articlePathStack.pushPathByName('bannerDetailPage', item);
          })
      }, (item: BannerClass, index: number) => item.id)
    }
    .autoPlay(true)
    .loop(true)
    .displayCount(new BreakpointType({ sm: 1, md: 2, lg: 2 }).getValue(this.currentBreakpoint))
    .displayMode(SwiperDisplayMode.STRETCH)
    .indicator(this.currentBreakpoint === BreakpointTypeEnum.SM ?Indicator.dot().color('#1a000000').selectedColor('#0A59F7') : false)
    .nextMargin(new BreakpointType<Length>({ sm: 0, md: 12, lg: 266 }).getValue(this.currentBreakpoint))
    .indicator(
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#0A59F7'))
  }
}