facebook_ane
============

FaceBook ANE使用

Air APP  使用Facebook功能
ane https://github.com/freshplanet/ANE-Facebook

extensions : com.freshplanet.AirFacebook

Android設定

<application>
<activity android:name="com.facebook.LoginActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar" android:label="@string/app_name" />
<activity android:name="com.freshplanet.ane.AirFacebook.LoginActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar"></activity>
<activity android:name="com.freshplanet.ane.AirFacebook.ShareDialogActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar"></activity>
<activity android:name="com.freshplanet.ane.AirFacebook.ShareOGActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar"></activity>
<activity android:name="com.freshplanet.ane.AirFacebook.WebDialogActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar"></activity>
</application>



打包時出現錯誤

dx tool failed:
UNEXPECTED TOP-LEVEL ERROR:
java.lang.OutOfMemoryError: Java heap space

原因：打包的资源太大造成内存不足
解决办法：
找到打包所用到adt.bat文件(在AIR sdk里面搜索即可）
      用记事本打开 上面写着@java -jar "%~dp0\..\lib\adt.jar" %*
改成：set javaOpts=-Xmx512M
            @java %javaOpts% -jar "%~dp0\..\lib\adt.jar" %*
这样就把adt可用内存设置为512m了，也可以设大一点。
http://wiki.dartou.com/forum.php?mod=viewthread&tid=4


Facebook develop設定

Android  Key Hashes
使用別名及 p12 檔案進行查詢

 	keytool -export -alias 1 -storetype pkcs12 -keystore [YourP12.p12] | openssl sha1 -binary | openssl enc -a -e

http://lamb-mei.com/400/e-android-key-hash-for-facebook-from-an-air-app/


Code
//init
Facebook.getInstance().init( FacebookConfig.appID );
Facebook.getInstance().logEnabled = true;

//share
if(Facebook.getInstance().canPresentShareDialog())
Facebook.getInstance().shareLinkDialog( "http://freshplanet.com/", null, null, null, null, errorHandler );
else
Facebook.getInstance().webDialog( "feed", { 'link':"http://freshplanet.com" }, errorHandler );
