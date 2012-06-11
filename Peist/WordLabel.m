//
//  WordButton.m
//  SV
//
//  Created by 배 철희 on 12. 3. 24..
//  Copyright (c) 2012년 . All rights reserved.
//

#import "WordLabel.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import "ViewController.h"
#import "PastedScrollView.h"
/*
 Family: Thonburi
 2012-03-27 00:04:03.406 Pasty[10792:f803] 	Font: Thonburi-Bold
 2012-03-27 00:04:03.406 Pasty[10792:f803] 	Font: Thonburi
 2012-03-27 00:04:03.407 Pasty[10792:f803] 
 Family: Snell Roundhand
 2012-03-27 00:04:03.407 Pasty[10792:f803] 	Font: SnellRoundhand-Bold
 2012-03-27 00:04:03.408 Pasty[10792:f803] 	Font: SnellRoundhand-Black
 2012-03-27 00:04:03.408 Pasty[10792:f803] 	Font: SnellRoundhand
 2012-03-27 00:04:03.409 Pasty[10792:f803] 
 Family: Academy Engraved LET
 2012-03-27 00:04:03.409 Pasty[10792:f803] 	Font: AcademyEngravedLetPlain
 2012-03-27 00:04:03.410 Pasty[10792:f803] 
 Family: Marker Felt
 2012-03-27 00:04:03.411 Pasty[10792:f803] 	Font: MarkerFelt-Wide
 2012-03-27 00:04:03.411 Pasty[10792:f803] 	Font: MarkerFelt-Thin
 2012-03-27 00:04:03.412 Pasty[10792:f803] 
 Family: Geeza Pro
 2012-03-27 00:04:03.412 Pasty[10792:f803] 	Font: GeezaPro-Bold
 2012-03-27 00:04:03.413 Pasty[10792:f803] 	Font: GeezaPro
 2012-03-27 00:04:03.429 Pasty[10792:f803] 
 Family: Arial Rounded MT Bold
 2012-03-27 00:04:03.430 Pasty[10792:f803] 	Font: ArialRoundedMTBold
 2012-03-27 00:04:03.430 Pasty[10792:f803] 
 Family: Trebuchet MS
 2012-03-27 00:04:03.431 Pasty[10792:f803] 	Font: TrebuchetMS
 2012-03-27 00:04:03.432 Pasty[10792:f803] 	Font: TrebuchetMS-Bold
 2012-03-27 00:04:03.432 Pasty[10792:f803] 	Font: TrebuchetMS-Italic
 2012-03-27 00:04:03.433 Pasty[10792:f803] 	Font: Trebuchet-BoldItalic
 2012-03-27 00:04:03.434 Pasty[10792:f803] 
 Family: Arial
 2012-03-27 00:04:03.434 Pasty[10792:f803] 	Font: Arial-BoldMT
 2012-03-27 00:04:03.435 Pasty[10792:f803] 	Font: ArialMT
 2012-03-27 00:04:03.436 Pasty[10792:f803] 	Font: Arial-ItalicMT
 2012-03-27 00:04:03.437 Pasty[10792:f803] 	Font: Arial-BoldItalicMT
 2012-03-27 00:04:03.438 Pasty[10792:f803] 
 Family: Marion
 2012-03-27 00:04:03.438 Pasty[10792:f803] 	Font: Marion-Regular
 2012-03-27 00:04:03.439 Pasty[10792:f803] 	Font: Marion-Bold
 2012-03-27 00:04:03.440 Pasty[10792:f803] 	Font: Marion-Italic
 2012-03-27 00:04:03.441 Pasty[10792:f803] 
 Family: Gurmukhi MN
 2012-03-27 00:04:03.441 Pasty[10792:f803] 	Font: GurmukhiMN
 2012-03-27 00:04:03.442 Pasty[10792:f803] 	Font: GurmukhiMN-Bold
 2012-03-27 00:04:03.443 Pasty[10792:f803] 
 Family: Malayalam Sangam MN
 2012-03-27 00:04:03.443 Pasty[10792:f803] 	Font: MalayalamSangamMN-Bold
 2012-03-27 00:04:03.444 Pasty[10792:f803] 	Font: MalayalamSangamMN
 2012-03-27 00:04:03.444 Pasty[10792:f803] 
 Family: Bradley Hand
 2012-03-27 00:04:03.445 Pasty[10792:f803] 	Font: BradleyHandITCTT-Bold
 2012-03-27 00:04:03.446 Pasty[10792:f803] 
 Family: Kannada Sangam MN
 2012-03-27 00:04:03.446 Pasty[10792:f803] 	Font: KannadaSangamMN
 2012-03-27 00:04:03.447 Pasty[10792:f803] 	Font: KannadaSangamMN-Bold
 2012-03-27 00:04:03.448 Pasty[10792:f803] 
 Family: Bodoni 72 Oldstyle
 2012-03-27 00:04:03.448 Pasty[10792:f803] 	Font: BodoniSvtyTwoOSITCTT-Book
 2012-03-27 00:04:03.449 Pasty[10792:f803] 	Font: BodoniSvtyTwoOSITCTT-Bold
 2012-03-27 00:04:03.450 Pasty[10792:f803] 	Font: BodoniSvtyTwoOSITCTT-BookIt
 2012-03-27 00:04:03.450 Pasty[10792:f803] 
 
 * Family: Cochin
 2012-03-27 00:04:03.451 Pasty[10792:f803] 	Font: Cochin
 2012-03-27 00:04:03.451 Pasty[10792:f803] 	Font: Cochin-BoldItalic
 2012-03-27 00:04:03.452 Pasty[10792:f803] 	Font: Cochin-Italic
 2012-03-27 00:04:03.453 Pasty[10792:f803] 	Font: Cochin-Bold
 2012-03-27 00:04:03.454 Pasty[10792:f803] 
 Family: Sinhala Sangam MN
 2012-03-27 00:04:03.455 Pasty[10792:f803] 	Font: SinhalaSangamMN
 2012-03-27 00:04:03.455 Pasty[10792:f803] 	Font: SinhalaSangamMN-Bold
 2012-03-27 00:04:03.456 Pasty[10792:f803] 
 Family: Hiragino Kaku Gothic ProN
 2012-03-27 00:04:03.456 Pasty[10792:f803] 	Font: HiraKakuProN-W6
 2012-03-27 00:04:03.457 Pasty[10792:f803] 	Font: HiraKakuProN-W3
 2012-03-27 00:04:03.458 Pasty[10792:f803] 
 Family: Papyrus
 2012-03-27 00:04:03.459 Pasty[10792:f803] 	Font: Papyrus-Condensed
 2012-03-27 00:04:03.459 Pasty[10792:f803] 	Font: Papyrus
 2012-03-27 00:04:03.460 Pasty[10792:f803] 
 Family: Verdana
 2012-03-27 00:04:03.461 Pasty[10792:f803] 	Font: Verdana
 2012-03-27 00:04:03.461 Pasty[10792:f803] 	Font: Verdana-Bold
 2012-03-27 00:04:03.462 Pasty[10792:f803] 	Font: Verdana-BoldItalic
 2012-03-27 00:04:03.462 Pasty[10792:f803] 	Font: Verdana-Italic
 2012-03-27 00:04:03.463 Pasty[10792:f803] 
 Family: Zapf Dingbats
 2012-03-27 00:04:03.464 Pasty[10792:f803] 	Font: ZapfDingbatsITC
 2012-03-27 00:04:03.464 Pasty[10792:f803] 
 Family: Courier
 2012-03-27 00:04:03.465 Pasty[10792:f803] 	Font: Courier-Bold
 2012-03-27 00:04:03.466 Pasty[10792:f803] 	Font: Courier
 2012-03-27 00:04:03.466 Pasty[10792:f803] 	Font: Courier-BoldOblique
 2012-03-27 00:04:03.467 Pasty[10792:f803] 	Font: Courier-Oblique
 2012-03-27 00:04:03.468 Pasty[10792:f803] 
 Family: Hoefler Text
 2012-03-27 00:04:03.468 Pasty[10792:f803] 	Font: HoeflerText-Black
 2012-03-27 00:04:03.469 Pasty[10792:f803] 	Font: HoeflerText-Italic
 2012-03-27 00:04:03.470 Pasty[10792:f803] 	Font: HoeflerText-Regular
 2012-03-27 00:04:03.470 Pasty[10792:f803] 	Font: HoeflerText-BlackItalic
 2012-03-27 00:04:03.471 Pasty[10792:f803] 
 Family: Euphemia UCAS
 2012-03-27 00:04:03.472 Pasty[10792:f803] 	Font: EuphemiaUCAS-Bold
 2012-03-27 00:04:03.472 Pasty[10792:f803] 	Font: EuphemiaUCAS
 2012-03-27 00:04:03.473 Pasty[10792:f803] 	Font: EuphemiaUCAS-Italic
 2012-03-27 00:04:03.474 Pasty[10792:f803] 
 
 * Family: Helvetica
 2012-03-27 00:04:03.474 Pasty[10792:f803] 	Font: Helvetica-LightOblique
 2012-03-27 00:04:03.475 Pasty[10792:f803] 	Font: Helvetica
 2012-03-27 00:04:03.476 Pasty[10792:f803] 	Font: Helvetica-Oblique
 2012-03-27 00:04:03.477 Pasty[10792:f803] 	Font: Helvetica-BoldOblique
 2012-03-27 00:04:03.477 Pasty[10792:f803] 	Font: Helvetica-Bold
 2012-03-27 00:04:03.478 Pasty[10792:f803] 	Font: Helvetica-Light
 2012-03-27 00:04:03.479 Pasty[10792:f803] 
 Family: Hiragino Mincho ProN
 2012-03-27 00:04:03.479 Pasty[10792:f803] 	Font: HiraMinProN-W3
 2012-03-27 00:04:03.480 Pasty[10792:f803] 	Font: HiraMinProN-W6
 2012-03-27 00:04:03.480 Pasty[10792:f803] 
 Family: Bodoni Ornaments
 2012-03-27 00:04:03.481 Pasty[10792:f803] 	Font: BodoniOrnamentsITCTT
 2012-03-27 00:04:03.482 Pasty[10792:f803] 
 Family: Apple Color Emoji
 2012-03-27 00:04:03.482 Pasty[10792:f803] 	Font: AppleColorEmoji
 2012-03-27 00:04:03.483 Pasty[10792:f803] 
 Family: Optima
 2012-03-27 00:04:03.483 Pasty[10792:f803] 	Font: Optima-ExtraBlack
 2012-03-27 00:04:03.484 Pasty[10792:f803] 	Font: Optima-Italic
 2012-03-27 00:04:03.485 Pasty[10792:f803] 	Font: Optima-Regular
 2012-03-27 00:04:03.485 Pasty[10792:f803] 	Font: Optima-BoldItalic
 2012-03-27 00:04:03.486 Pasty[10792:f803] 	Font: Optima-Bold
 2012-03-27 00:04:03.486 Pasty[10792:f803] 
 Family: Gujarati Sangam MN
 2012-03-27 00:04:03.487 Pasty[10792:f803] 	Font: GujaratiSangamMN
 2012-03-27 00:04:03.487 Pasty[10792:f803] 	Font: GujaratiSangamMN-Bold
 2012-03-27 00:04:03.487 Pasty[10792:f803] 
 Family: Devanagari Sangam MN
 2012-03-27 00:04:03.513 Pasty[10792:f803] 	Font: DevanagariSangamMN
 2012-03-27 00:04:03.515 Pasty[10792:f803] 	Font: DevanagariSangamMN-Bold
 2012-03-27 00:04:03.516 Pasty[10792:f803] 
 Family: Times New Roman
 2012-03-27 00:04:03.516 Pasty[10792:f803] 	Font: TimesNewRomanPS-ItalicMT
 2012-03-27 00:04:03.517 Pasty[10792:f803] 	Font: TimesNewRomanPS-BoldMT
 2012-03-27 00:04:03.517 Pasty[10792:f803] 	Font: TimesNewRomanPSMT
 2012-03-27 00:04:03.519 Pasty[10792:f803] 	Font: TimesNewRomanPS-BoldItalicMT
 2012-03-27 00:04:03.521 Pasty[10792:f803] 
 Family: Kailasa
 2012-03-27 00:04:03.522 Pasty[10792:f803] 	Font: Kailasa
 2012-03-27 00:04:03.522 Pasty[10792:f803] 	Font: Kailasa-Bold
 2012-03-27 00:04:03.523 Pasty[10792:f803] 
 Family: Telugu Sangam MN
 2012-03-27 00:04:03.524 Pasty[10792:f803] 	Font: TeluguSangamMN-Bold
 2012-03-27 00:04:03.524 Pasty[10792:f803] 	Font: TeluguSangamMN
 2012-03-27 00:04:03.525 Pasty[10792:f803] 
 Family: Heiti SC
 2012-03-27 00:04:03.526 Pasty[10792:f803] 	Font: STHeitiSC-Medium
 2012-03-27 00:04:03.526 Pasty[10792:f803] 	Font: STHeitiSC-Light
 2012-03-27 00:04:03.527 Pasty[10792:f803] 
 Family: Apple SD Gothic Neo
 2012-03-27 00:04:03.528 Pasty[10792:f803] 	Font: AppleSDGothicNeo-Bold
 2012-03-27 00:04:03.529 Pasty[10792:f803] 	Font: AppleSDGothicNeo-Medium
 2012-03-27 00:04:03.529 Pasty[10792:f803] 
 Family: Futura
 2012-03-27 00:04:03.530 Pasty[10792:f803] 	Font: Futura-Medium
 2012-03-27 00:04:03.531 Pasty[10792:f803] 	Font: Futura-CondensedExtraBold
 2012-03-27 00:04:03.531 Pasty[10792:f803] 	Font: Futura-CondensedMedium
 2012-03-27 00:04:03.532 Pasty[10792:f803] 	Font: Futura-MediumItalic
 2012-03-27 00:04:03.533 Pasty[10792:f803] 
 Family: Bodoni 72
 2012-03-27 00:04:03.533 Pasty[10792:f803] 	Font: BodoniSvtyTwoITCTT-BookIta
 2012-03-27 00:04:03.534 Pasty[10792:f803] 	Font: BodoniSvtyTwoITCTT-Book
 2012-03-27 00:04:03.535 Pasty[10792:f803] 	Font: BodoniSvtyTwoITCTT-Bold
 2012-03-27 00:04:03.535 Pasty[10792:f803] 
 * Family: Baskerville
 2012-03-27 00:04:03.536 Pasty[10792:f803] 	Font: Baskerville-SemiBoldItalic
 2012-03-27 00:04:03.536 Pasty[10792:f803] 	Font: Baskerville-Bold
 2012-03-27 00:04:03.537 Pasty[10792:f803] 	Font: Baskerville-Italic
 2012-03-27 00:04:03.538 Pasty[10792:f803] 	Font: Baskerville-BoldItalic
 2012-03-27 00:04:03.538 Pasty[10792:f803] 	Font: Baskerville-SemiBold
 2012-03-27 00:04:03.539 Pasty[10792:f803] 	Font: Baskerville
 2012-03-27 00:04:03.540 Pasty[10792:f803] 
 Family: Chalkboard SE
 2012-03-27 00:04:03.540 Pasty[10792:f803] 	Font: ChalkboardSE-Regular
 2012-03-27 00:04:03.541 Pasty[10792:f803] 	Font: ChalkboardSE-Bold
 2012-03-27 00:04:03.542 Pasty[10792:f803] 	Font: ChalkboardSE-Light
 2012-03-27 00:04:03.542 Pasty[10792:f803] 
 Family: Heiti TC
 2012-03-27 00:04:03.543 Pasty[10792:f803] 	Font: STHeitiTC-Medium
 2012-03-27 00:04:03.544 Pasty[10792:f803] 	Font: STHeitiTC-Light
 2012-03-27 00:04:03.544 Pasty[10792:f803] 
 Family: Copperplate
 2012-03-27 00:04:03.545 Pasty[10792:f803] 	Font: Copperplate
 2012-03-27 00:04:03.546 Pasty[10792:f803] 	Font: Copperplate-Light
 2012-03-27 00:04:03.546 Pasty[10792:f803] 	Font: Copperplate-Bold
 2012-03-27 00:04:03.547 Pasty[10792:f803] 
 Family: Party LET
 2012-03-27 00:04:03.547 Pasty[10792:f803] 	Font: PartyLetPlain
 2012-03-27 00:04:03.548 Pasty[10792:f803] 
 Family: American Typewriter
 2012-03-27 00:04:03.549 Pasty[10792:f803] 	Font: AmericanTypewriter-CondensedLight
 2012-03-27 00:04:03.549 Pasty[10792:f803] 	Font: AmericanTypewriter-Light
 2012-03-27 00:04:03.550 Pasty[10792:f803] 	Font: AmericanTypewriter-Bold
 2012-03-27 00:04:03.551 Pasty[10792:f803] 	Font: AmericanTypewriter
 2012-03-27 00:04:03.551 Pasty[10792:f803] 	Font: AmericanTypewriter-CondensedBold
 2012-03-27 00:04:03.552 Pasty[10792:f803] 	Font: AmericanTypewriter-Condensed
 2012-03-27 00:04:03.553 Pasty[10792:f803] 
 Family: Bangla Sangam MN
 2012-03-27 00:04:03.554 Pasty[10792:f803] 	Font: BanglaSangamMN-Bold
 2012-03-27 00:04:03.554 Pasty[10792:f803] 	Font: BanglaSangamMN
 2012-03-27 00:04:03.555 Pasty[10792:f803] 
 Family: Noteworthy
 2012-03-27 00:04:03.556 Pasty[10792:f803] 	Font: Noteworthy-Light
 2012-03-27 00:04:03.573 Pasty[10792:f803] 	Font: Noteworthy-Bold
 2012-03-27 00:04:03.573 Pasty[10792:f803] 
 * Family: Zapfino
 2012-03-27 00:04:03.574 Pasty[10792:f803] 	Font: Zapfino
 2012-03-27 00:04:03.574 Pasty[10792:f803] 
 Family: Tamil Sangam MN
 2012-03-27 00:04:03.575 Pasty[10792:f803] 	Font: TamilSangamMN
 2012-03-27 00:04:03.575 Pasty[10792:f803] 	Font: TamilSangamMN-Bold
 2012-03-27 00:04:03.577 Pasty[10792:f803] 
 Family: DB LCD Temp
 2012-03-27 00:04:03.577 Pasty[10792:f803] 	Font: DBLCDTempBlack
 2012-03-27 00:04:03.578 Pasty[10792:f803] 
 Family: Arial Hebrew
 2012-03-27 00:04:03.579 Pasty[10792:f803] 	Font: ArialHebrew
 2012-03-27 00:04:03.580 Pasty[10792:f803] 	Font: ArialHebrew-Bold
 2012-03-27 00:04:03.580 Pasty[10792:f803] 
 Family: Chalkduster
 2012-03-27 00:04:03.581 Pasty[10792:f803] 	Font: Chalkduster
 2012-03-27 00:04:03.581 Pasty[10792:f803] 
 Family: Georgia
 2012-03-27 00:04:03.582 Pasty[10792:f803] 	Font: Georgia-Italic
 2012-03-27 00:04:03.582 Pasty[10792:f803] 	Font: Georgia-BoldItalic
 2012-03-27 00:04:03.583 Pasty[10792:f803] 	Font: Georgia-Bold
 2012-03-27 00:04:03.583 Pasty[10792:f803] 	Font: Georgia
 2012-03-27 00:04:03.583 Pasty[10792:f803] 
 * Family: Helvetica Neue
 2012-03-27 00:04:03.584 Pasty[10792:f803] 	Font: HelveticaNeue-Bold
 2012-03-27 00:04:03.585 Pasty[10792:f803] 	Font: HelveticaNeue-CondensedBlack
 2012-03-27 00:04:03.612 Pasty[10792:f803] 	Font: HelveticaNeue-Medium
 2012-03-27 00:04:03.613 Pasty[10792:f803] 	Font: HelveticaNeue
 2012-03-27 00:04:03.613 Pasty[10792:f803] 	Font: HelveticaNeue-Light
 2012-03-27 00:04:03.614 Pasty[10792:f803] 	Font: HelveticaNeue-CondensedBold
 2012-03-27 00:04:03.615 Pasty[10792:f803] 	Font: HelveticaNeue-LightItalic
 2012-03-27 00:04:03.615 Pasty[10792:f803] 	Font: HelveticaNeue-UltraLightItalic
 2012-03-27 00:04:03.616 Pasty[10792:f803] 	Font: HelveticaNeue-UltraLight
 2012-03-27 00:04:03.616 Pasty[10792:f803] 	Font: HelveticaNeue-BoldItalic
 2012-03-27 00:04:03.617 Pasty[10792:f803] 	Font: HelveticaNeue-Italic
 2012-03-27 00:04:03.617 Pasty[10792:f803] 
 Family: Gill Sans
 2012-03-27 00:04:03.618 Pasty[10792:f803] 	Font: GillSans-LightItalic
 2012-03-27 00:04:03.619 Pasty[10792:f803] 	Font: GillSans-BoldItalic
 2012-03-27 00:04:03.619 Pasty[10792:f803] 	Font: GillSans-Italic
 2012-03-27 00:04:03.620 Pasty[10792:f803] 	Font: GillSans
 2012-03-27 00:04:03.621 Pasty[10792:f803] 	Font: GillSans-Bold
 2012-03-27 00:04:03.621 Pasty[10792:f803] 	Font: GillSans-Light
 2012-03-27 00:04:03.622 Pasty[10792:f803] 
 * Family: Palatino
 2012-03-27 00:04:03.623 Pasty[10792:f803] 	Font: Palatino-Roman
 2012-03-27 00:04:03.623 Pasty[10792:f803] 	Font: Palatino-Bold
 2012-03-27 00:04:03.625 Pasty[10792:f803] 	Font: Palatino-BoldItalic
 2012-03-27 00:04:03.625 Pasty[10792:f803] 	Font: Palatino-Italic
 2012-03-27 00:04:03.626 Pasty[10792:f803] 
 Family: Courier New
 2012-03-27 00:04:03.627 Pasty[10792:f803] 	Font: CourierNewPSMT
 2012-03-27 00:04:03.627 Pasty[10792:f803] 	Font: CourierNewPS-BoldMT
 2012-03-27 00:04:03.628 Pasty[10792:f803] 	Font: CourierNewPS-BoldItalicMT
 2012-03-27 00:04:03.629 Pasty[10792:f803] 	Font: CourierNewPS-ItalicMT
 2012-03-27 00:04:03.629 Pasty[10792:f803] 
 Family: Oriya Sangam MN
 2012-03-27 00:04:03.630 Pasty[10792:f803] 	Font: OriyaSangamMN-Bold
 2012-03-27 00:04:03.630 Pasty[10792:f803] 	Font: OriyaSangamMN
 2012-03-27 00:04:03.631 Pasty[10792:f803] 
 Family: Didot
 2012-03-27 00:04:03.632 Pasty[10792:f803] 	Font: Didot-Italic
 2012-03-27 00:04:03.632 Pasty[10792:f803] 	Font: Didot
 2012-03-27 00:04:03.633 Pasty[10792:f803] 	Font: Didot-Bold
 2012-03-27 00:04:03.633 Pasty[10792:f803] 
 Family: Bodoni 72 Smallcaps
 2012-03-27 00:04:03.634 Pasty[10792:f803] 	Font: BodoniSvtyTwoSCITCTT-Book
 */

NSString * const DEFAULT_FONT_NAME = @"Palatino";
//NSString * const DEFAULT_FONT_NAME = @"HelveticaNeue";
//NSString * const DEFAULT_FONT_NAME = @"Cochin-Bold";
//NSString * const DEFAULT_FONT_NAME = @"Baskerville";
//NSString * const DEFAULT_FONT_NAME = @"GillSans";
NSInteger const DEFAULT_FONT_SIZE = 21;

@interface WordLabel ()
@end

@implementation WordLabel

@synthesize isTapped = _isTapped;
@synthesize delegate = _delegate;
@synthesize fontName = _fontName;
@synthesize fontSize = _fontSize;
@synthesize textLabel = _textLabel;


/**
 버튼 타이틀만 인자로 받는 initializer
 */
- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initWithFrame:frame title:title fontName:nil fontSize:0];
    }
    
    return self;
}

/**
 버튼 타이틀과 사이즈를 인자로 받는 initializer
 */
- (id)initWithFrame:(CGRect)frame title:(NSString *)title fontName:(NSString *)fontName fontSize:(CGFloat)fontSize {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initWithFrame:frame title:title fontName:fontName fontSize:fontSize];
    }
    
    return self;
}

/**
 버튼 타이틀과 사이즈를 인자로 모두 받을 수 있는 initializer
 */
- (id)_initWithFrame:(CGRect)frame title:(NSString *)title fontName:(NSString *)fontName fontSize:(CGFloat)fontSize {
    isFirst = YES;
    self.userInteractionEnabled = YES;
    
    self.text = title;
    
//    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
//    ViewController *viewController = (ViewController *)frontWindow.rootViewController;
//    self.backgroundColor = viewController.scrollView.backgroundColor;
//    frontWindow = nil;
//    viewController = nil;
    
    if (fontSize != 0) {
        self.fontSize = fontSize;
    } else {
        self.fontSize = DEFAULT_FONT_SIZE;
    }
    
    if (fontName != nil) {
        self.fontName = fontName;
    } else {
        self.fontName = DEFAULT_FONT_NAME;
    }
    
    [self setFont:[UIFont fontWithName:self.fontName size:self.fontSize]];
    self.shadowColor = [UIColor whiteColor];
    self.shadowOffset = CGSizeMake(1.0f, 1.0f);
    [self sizeToFit];
    
    //단어 길이가 디바이스 너비보다 길 경우
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (self.frame.size.width >= screenRect.size.width) {
        self.lineBreakMode = UILineBreakModeWordWrap | UILineBreakModeTailTruncation;
        self.numberOfLines = 1;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, screenRect.size.width - 15, self.frame.size.height);
    }
    
    // 단어 터치 이벤트 등록, 스크롤 드래깅이 안될 때 스크롤 객체에서 확인
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
    [tapRecognizer addTarget:self action:@selector(tapped)];
    [self addGestureRecognizer:tapRecognizer];
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] init];
    [longPressRecognizer addTarget:self action:@selector(longPressed)];
    [self addGestureRecognizer:longPressRecognizer];
    
    // 장문 붙여넣기 붙여넣는 단어마다 바로바로 보이고 빠르게 싱크되어 나타내기 - 배경색이 랜덤하게 한두개씩 배경이 검정색(nil)로 세팅되는 현상 방지용
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    ViewController *viewController = (ViewController *)frontWindow.rootViewController;
    self.backgroundColor = viewController.scrollView.backgroundColor;
    
    return self;
}

- (void)changeSelectedState:(BOOL)state {
    self.isTapped = state;
    
    if (state) {
        CGRect oldFrame = self.frame;

        self.textColor = [UIColor blackColor];
        [self setBackgroundColor:[[UIColor alloc] initWithRed:255.0f/255.0f green:230.0f/255.0f blue:70.0f/255.0f alpha:1]];

        self.frame = CGRectMake(self.center.x, self.center.y, 0, 0);
        
        // gloss effect 시 텍스트가 가려지는 현상 때문에 추가
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.frame = self.frame;
        self.textLabel.font = self.font;
        self.textLabel.text = self.text;
//        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [[UIColor alloc] initWithRed:255.0f/255.0f green:190.0f/255.0f blue:20.0f/255.0f alpha:1].CGColor;
        self.layer.borderWidth = 1.0f;
        
        //애니매이션 준비
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration: 0.13f];
        
        //버튼 크기 변경
        self.frame = oldFrame;
        self.textLabel.frame = oldFrame;
        self.layer.cornerRadius = 5.0f;

//        self.layer.borderWidth = 1;
//        self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
//        self.layer.shadowOpacity = 0.5; // shadow opacity를 줄 경우 느려짐. 이거 어떻게 해야 하나, 아래 라인 추가로 해결
//        self.layer.shadowRadius = 2.0f;
//        
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.layer.opacity = 1;
//        
//        self.layer.shouldRasterize = YES;
//        // http://stackoverflow.com/questions/3677564/drawing-shadow-with-quartz-is-slow-on-iphone-ipad-another-way
//        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5.0f].CGPath;
        
        //애니매이션 적용
        [UIView commitAnimations];
    } else {
        for (CALayer* layer in [self.layer sublayers]) {
            [layer removeAllAnimations];
        }
        self.layer.cornerRadius = 0.0f; // uilabel cornerRadius가 엄청나게 퍼포먼스에 영향을 줌
        self.textColor = [UIColor blackColor];
        [self.textLabel removeFromSuperview];
        self.textLabel = nil;
        self.backgroundColor = self.superview.backgroundColor;
        //self.shadowColor = nil;
        self.layer.borderWidth = 0;
        self.layer.shadowOpacity = 0;
        self.layer.shadowOffset = CGSizeMake(0, 0);
    }
    
}

- (void)removeFromSuperview {
    [self.textLabel removeFromSuperview];
    [super removeFromSuperview];
}

- (void)longPressed {
    [[self delegate] wordLongPressed:self];
}

- (void)tapped {
    [[self delegate] wordTouched:self];
}

- (void)drawRect:(CGRect)rect 
{
    // gloss effect는 탭 할 때만
    if (self.isTapped) {
        [super drawRect:rect];
        
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        
        CGGradientRef glossGradient;
        CGColorSpaceRef rgbColorspace;
        size_t num_locations = 2;
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = { 1.0, 1.0, 1.0, 0.50,  // Start color
            1.0, 1.0, 1.0, 0.10 }; // End color
        
        rgbColorspace = CGColorSpaceCreateDeviceRGB();
        glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
        
        CGRect currentBounds = self.bounds;
        CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
        CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
        
        CGContextDrawLinearGradient(currentContext, glossGradient, topCenter, midCenter, 0);
        
        CGGradientRelease(glossGradient);
        CGColorSpaceRelease(rgbColorspace);
    } else {
        // 장문 붙여넣기 붙여넣는 단어마다 바로바로 보이고 빠르게 싱크되어 나타내기 - 배경색이 랜덤하게 한두개씩 배경이 검정색(nil)로 세팅되는 현상 방지용
        if (isFirst) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetFillColor(context, CGColorGetComponents( [self.superview.backgroundColor CGColor]));
            CGContextFillRect(context, rect);
            isFirst = NO;
        }
        [super drawRect:rect];
    }

}


@end
