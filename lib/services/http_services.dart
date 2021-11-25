import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fometic/components/get_http_provider.dart';
import 'package:fometic/models/form_token_model.dart';
import 'package:get/get.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart' as universalHttp;

final logger = SimpleLogger();
class HttpServices extends GetxService {
  dynamic httpClient;
  Map<String, String> requestHeader = <String, String>{};
  String lastSessionId = "";
  String flutterWebSessionId = "";

  static const FORMTOKENURI = 'https://setaraws.herokuapp.com/?c=formws&m=formtoken';
  static const FORMTOKENSESSIONURI = 'https://setaraws.herokuapp.com/?c=formws&m=formtokensession';
  static const TESTAPI = 'https://dog.ceo/api/breeds/list/all';
  void initServices() {
    logger.info("initServices");
  }

  @override
  void onInit() {
    super.onInit();
    httpClient = http.Client();
  }

  Future<FormToken?> getFormToken() async {
    var jsonData;
    if(kIsWeb) {
      jsonData = await webHttpGetToken(flutterWebSessionId);
      flutterWebSessionId = jsonData['sessionId'];
      //jsonData = await getxHttpGetToken();  // not working
      //jsonData = await webHttpGetToken();   //cookie not working, always create new session
      //jsonData = await webUniversalHttpGetToken();
      //jsonData = await webHttpGetToken2();
    }else {
      jsonData = await httpGetToken();
    }
    if (jsonData != null){
      return FormToken.fromJson(jsonData);
    } else {
      return null;
    }

  }

  Future<dynamic> getxHttpGetToken() async {
    var getHttpProvider = GetHttpProvider();
    logger.info("lastSessionId $lastSessionId");
    if (lastSessionId != "") {
      requestHeader["Cookie"] = "ci_session=$lastSessionId";
    }
    final response = await getHttpProvider.get(FORMTOKENURI, headers: requestHeader);
    logger.info('getxHttpGetToken response = ${response.toString()}');
    if (response.status.isOk) {
      logger.info("getxHttpGetToken ${response.toString()}");
      if(response.headers!.containsKey('x-session-id')) {
        lastSessionId = response.headers!['x-session-id']!;
      } else {
        lastSessionId ="";
      }
      logger.info("httpGetToken body : ${response.body.toString()}");
      var tmpJsonData= jsonDecode(response.body);

      tmpJsonData['csrfTokenId'] = response.headers!['x-csrf-token'];
      return tmpJsonData;
    } else {
      logger.info("getxHttpGetToken status : ${response.statusCode} ${response.body.runtimeType}");
      return null;
    }
  }

  Future<dynamic> webUniversalHttpGetToken() async {
    //final response = await http.get(Uri.parse('https://setaraws.herokuapp.com/?c=formws&m=formtoken'));
    final universalHttpClient = universalHttp.HttpClient();
    logger.info("lastSessionId $lastSessionId");
    final request = await universalHttpClient.getUrl(Uri.parse(FORMTOKENURI));
    if (lastSessionId != "") {
      request.headers.set("Cookie", "ci_session=$lastSessionId");
    }
    logger.info("requestHeader : ${requestHeader.toString()}");


    if (request is universalHttp.BrowserHttpClientRequest) {
      request.browserCredentialsMode = true;
      request.browserResponseType = "json";
    }
    final response = await request.close();
    logger.info("httpGetToken");
    if (response.statusCode == 200) {
      logger.info("httpGetToken header : ${response.headers.toString()}");
      logger.info("httpGetToken body : ${response.length}");
      lastSessionId = response.headers.value('x-session-id')!;
      //requestHeader.assign("set-cookie", response.headers["set-cookie"]);
      //lastSessionId = response.headers['x-session-id'];
      //logger.info("httpGetToken body : ${response.body.toString()}");
      //var tmpJsonData= jsonDecode(response.body);
      //tmpJsonData['csrfTokenId'] = response.headers['x-csrf-token'];
      //tempFormToken = FormToken.fromJson(tmpJsonData);
      return null; //tmpJsonData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load form token');
      return null;
    }

    //logger.info("httpGetToken ${tempFormToken!.toJsonString()}");
  }

  Future<dynamic> webHttpGetToken3() async {
    //final response = await http.get(Uri.parse('https://setaraws.herokuapp.com/?c=formws&m=formtoken'));

    logger.info("lastSessionId $lastSessionId");
    if (lastSessionId != "") {
      requestHeader["Set-Cookie"] = "ci_session=$lastSessionId";
    }
    logger.info("requestHeader : ${requestHeader.toString()}");

    final response = await  httpClient.get(Uri.parse(FORMTOKENURI), headers:requestHeader);
    logger.info("httpGetToken");
    if (response.statusCode == 200) {
      logger.info("httpGetToken header : ${response.headers.toString()}");
      //requestHeader.assign("set-cookie", response.headers["set-cookie"]);
      lastSessionId = response.headers['x-session-id'];
      logger.info("httpGetToken body : ${response.body.toString()}");
      var tmpJsonData= jsonDecode(response.body);
      tmpJsonData['csrfTokenId'] = response.headers['x-csrf-token'];
      //tempFormToken = FormToken.fromJson(tmpJsonData);
      return tmpJsonData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load form token');
      return null;
    }

    //logger.info("httpGetToken ${tempFormToken!.toJsonString()}");
  }

  Future<dynamic> webHttpGetToken2() async {
    //final response = await http.get(Uri.parse('https://setaraws.herokuapp.com/?c=formws&m=formtoken'));
    final universalHttpClient = universalHttp.HttpClient();
    logger.info("webHttpGetToken2 lastSessionId $lastSessionId");
    if (lastSessionId != "") {
      requestHeader["Set-Cookie"] = "ci_session=$lastSessionId";
    } else {
      requestHeader["Set-Cookie"] = "ci_session=";
    }
    logger.info("requestHeader : ${requestHeader.toString()}");

    final request = await universalHttpClient.getUrl(Uri.parse(FORMTOKENURI));
    if (request is universalHttp.BrowserHttpClientRequest) {
      request.browserCredentialsMode = true;
      request.browserResponseType = "json";
      var cookieSession = universalHttp.Cookie("Cookie", requestHeader["Set-Cookie"]!);
      request.cookies.add(cookieSession);

    }
    final response = await request.close();

    logger.info("httpGetToken");
    if (response.statusCode == 200) {
      logger.info("httpGetToken header : ${response.headers.toString()}");
      //requestHeader.assign("set-cookie", response.headers["set-cookie"]);
      lastSessionId = response.headers.value('x-session-id')!;
      logger.info("httpGetToken body : ${response.toString()}");
      //var tmpJsonData= jsonDecode(response.body);
      //tmpJsonData['csrfTokenId'] = response.headers['x-csrf-token'];
      //tempFormToken = FormToken.fromJson(tmpJsonData);
      return null; //tmpJsonData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load form token');
      return null;
    }

    //logger.info("httpGetToken ${tempFormToken!.toJsonString()}");
  }

  Future<dynamic> httpGetToken() async {
    //final response = await http.get(Uri.parse('https://setaraws.herokuapp.com/?c=formws&m=formtoken'));
    if (lastSessionId != "") {
      requestHeader["Cookie"] = "ci_session=$lastSessionId";
    }
    requestHeader["Access-Control-Allow-Origin"] = "*";
    logger.info("requestHeader : ${requestHeader.toString()}");
    final response = await  httpClient.get(Uri.parse(FORMTOKENURI), headers:requestHeader);
    logger.info("httpGetToken");
    if (response.statusCode == 200) {
      logger.info("httpGetToken header : ${response.headers.toString()}");
      //requestHeader.assign("set-cookie", response.headers["set-cookie"]);
      lastSessionId = response.headers['x-session-id'];
      logger.info("httpGetToken body : ${response.body.toString()}");
      logger.info("httpGetToken Process");
      var tmpJsonData= jsonDecode(response.body);
      tmpJsonData['csrfTokenId'] = response.headers['x-csrf-token'];
      //tempFormToken = FormToken.fromJson(tmpJsonData);
      return tmpJsonData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load form token');
      return null;
    }

    //logger.info("httpGetToken ${tempFormToken!.toJsonString()}");
  }

  Future<dynamic> webHttpGetToken(String xhrSessionId) async {
    //final response = await http.get(Uri.parse('https://setaraws.herokuapp.com/?c=formws&m=formtoken'));
    String webUriString = '$FORMTOKENSESSIONURI&fsessionid=$xhrSessionId';
    if (lastSessionId != "") {
      requestHeader["Cookie"] = "ci_session=$lastSessionId";
    }
    requestHeader["Access-Control-Allow-Origin"] = "*";
    logger.info("requestHeader : ${requestHeader.toString()}");
    final response = await  httpClient.get(Uri.parse(webUriString), headers:requestHeader);
    logger.info("httpGetToken");
    if (response.statusCode == 200) {
      logger.info("httpGetToken header : ${response.headers.toString()}");
      //requestHeader.assign("set-cookie", response.headers["set-cookie"]);
      lastSessionId = response.headers['x-session-id'];
      logger.info("httpGetToken body : ${response.body.toString()}");
      logger.info("httpGetToken Process");
      var tmpJsonData= jsonDecode(response.body);
      tmpJsonData['csrfTokenId'] = response.headers['x-csrf-token'];
      //tempFormToken = FormToken.fromJson(tmpJsonData);
      return tmpJsonData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load form token');
      return null;
    }

    //logger.info("httpGetToken ${tempFormToken!.toJsonString()}");
  }

}



/*
header : {connection: keep-alive, set-cookie: csrf_cookie_name=84bc0038301e82eb5889de95967830a4;
expires=Sun, 21-Nov-2021 05:05:23 GMT; Max-Age=7200; path=/,ci_session=p29c3m1dgcv825crhgjim075l92umr28;
expires=Sun, 21-Nov-2021 05:05:23 GMT; Max-Age=7200; path=/; HttpOnly, cache-control: no-store, no-cache,
must-revalidate, transfer-encoding: chunked, date: Sun, 21 Nov 2021 03:05:23 GMT,
x-csrf-token: 84bc0038301e82eb5889de95967830a4, via: 1.1 vegur, content-type: application/json; charset=UTF-8,
pragma: no-cache, x-session_id: p29c3m1dgcv825crhgjim075l92umr28, server: Apache,
expires: Thu, 19 Nov 1981 08:52:00 GMT}

body : {"sessionId":"p29c3m1dgcv825crhgjim075l92umr28","sessionTokensId":"13"}

 */