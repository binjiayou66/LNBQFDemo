//
//  PublicDefine.h
//  LNBQFDemo
//
//  Created by Naibin on 15/11/26.
//  Copyright (c) 2015年 QianFeng. All rights reserved.
//

#ifndef LNBQFDemo_PublicDefine_h
#define LNBQFDemo_PublicDefine_h

#define MAIN_COLOR [UIColor colorWithRed:123 / 255.0 green:195 / 255.0 blue:0 / 255.0 alpha:1]


//锋向标接口

//主机地址
#define HOST @"http://app.1000phone.com"

//主URL
#define MAIN_URL @"/api/index.php?m=api&a=lists&category_id=%ld&page=%ld&position_id=1"

#define MAIN_URL_FIRST_PAGE @"/api/index.php?m=api&a=lists&category_id=%ld&page=1&position_id=1"

//学习
#define STUDY_URL @"/api/index.php?m=api&a=show&id=%@"

//详情页
#define DETAIL_URL @"/api/index.php?m=api&a=show&id=%@"

//urlH5
#define H5_URL @"http://app.1000phone.com/api/index.php?m=api&a=showH5&id=%@"

//详情评论页
#define REVIEW_URL @"/api/index.php?m=api&a=newsCommentList&news_id=742&page=1"


//合作身份者id，以2088开头的16位纯数字
#define PARTNER    @"2088611922925773"
//收款支付宝账号
#define SELLER     @"crg__ok@126.com"

//支付宝公钥
#define AlipayPubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDXxDhrhw8kras3rbt+4DtC8cvbnAlaU97e6GqP6GB8nkCISOLMbu3Z020nbEdwyoJR4PvbDWyL7m8cXiz7346xfy75MtLGCBgUWMkF0G/pMDqtHcKhxr6jeBT9RMCOvQn0D/2tif8+A9LLRf4bb+AduHcWoO5sWSCiySb8LLVG5wIDAQAB"

//商户私钥，自助生成
#define PartnerPrivKey  @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANfEOGuHDyStqzetu37gO0Lxy9ucCVpT3t7oao/oYHyeQIhI4sxu7dnTbSdsR3DKglHg+9sNbIvubxxeLPvfjrF/Lvky0sYIGBRYyQXQb+kwOq0dwqHGvqN4FP1EwI69CfQP/a2J/z4D0stF/htv4B24dxag7mxZIKLJJvwstUbnAgMBAAECgYEAtVsDhTXPP6gNqs4HM3xrszgjfiIoJlkqkjfOIclTGEu3uBVzNBvlJdq0+5bicWZ1pTay2ors+qzdjX2G1+ovN2x9ZIZyVDL0P1CqgzwEu7hCIC5I/hlcMIux+h0U93stRxeimdCcbj2hCfzewE77hP4GQ6F4llzgDtvm9X41CYkCQQDy+63bcv7huWydUOuN7ObhOTAjoAe5SxJL89UkFkMGwJYqUm2cRNAkaJ3OPBBBXEeDpBjh323L6g0pUnM6q32lAkEA41NJY+GAXVUAWnAKNJHfXEi3XopnStsPRRL6gRCqTcceWEicq6CtyHEIxJuldiG0AP2u+Fh5faWx4phXKFEkmwJAFdGt2f/ojWJ2M2Y50MPOM7lL7lcHeocYPIPHxvbMzAVtNp2yRA8V1b8jNIrGNuhPb63DojzLAj2hMu25dTJDFQJAFi24CVCk73YtlKU9uadJvX0ytryWG02IDdsuKY1wsCnvIfnjnzMMAXRVwKjW2dGr+DTH717ia4nQ8ySdzEcuZQJAf1aGvpNuRP9Sf043ymPbhBVEb2bji6ltOr9R1VpCuaojP/EAYEAanzHLvcG+kc0QAk57+7hWp3smNQu+aYt1oQ=="

#endif
