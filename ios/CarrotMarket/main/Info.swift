//
//  Testing.swift
//  ios
//
//  Created by 태로고침 on 2020/09/07.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import Foundation
//MARK: - testing
var MYTOWN: String = "" // 동네 이름 저장
var PLACE_ID: Int = 0   // 동네 ID 값은 JWT 처럼 사용
var PHONENUMBER: String = "" // 사용자 폰 넘버
var ISMEMBER: Int = 0 // 회원여부 확인 0:비회원, 1:회원 / 프로필 작성 여부
var USER_NICKNAME: String = "" // 유저 닉네임

var USER_IMAGE: String = "" // 유저 사진
var MYLATITUDE: Float = 0
var MYLONGITUDE: Float = 0
var DISTANCE: Float = 0
var JWT : String = "" //jwt

var POST_ID: Int = 0 //게시글 아이디
var CATEGORY: Int = 0 //카테고리
var SELLER_ID: Int = 0 //상세 상품내역 - 판매자의 아이디 -> 이걸 통해서 게시글 수정/삭제 권한 부여
var MY_ID: Int = 0      //유저 자신의 아이디 넘버 -> 이걸 통해서 게시글 수정/ 삭제 권한 부여 (둘이 비교)
var PAGE_NUM_NEIGHBORHOOD: Int = 0 // 페이지 넘버 - 동네
var PAGE_NUM_ITEMS: Int = 0
