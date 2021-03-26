import 'package:js_packer/js_packer.dart';

void main() {
  var eval =
      "eval(function(p,a,c,k,e,r){e=String;if(!''.replace(/^/,String)){while(c--)r[c]=k[c]||c;k=[function(e){return r[e]}];e=function(){return'\\\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\\\b'+e(c)+'\\\\b','g'),k[c]);return p}('2(0){1(\"3: \"+0);1(\"4\")}',5,5,'str|alert|function|message|ok'.split('|'),0,{}))";

  var jsPacker = JSPacker(eval);

  // detect link
  if (jsPacker.detect()) {
    print(jsPacker.unpack()); // get value
  } else {
    print('Not P.A.C.K.E.R. coded');
  }

  // print function(str){alert("message: "+str);alert("ok")}
}
