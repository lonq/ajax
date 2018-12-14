var _gwebsitename, _gwebsiteurl, _gtel, _gmobiletel, _gfax, _gqq, _gmsn, _gwebsiteemail, _gaddress, _gpostcode, _gwebsitemaster, _gwebsitemasteremail, _gwebsiteusers, _gwebsiteusersemail, _gtechnology, _gtechnologyemail, _gcopyright, _gicp, _gsitestatistics, _gscripttimeout, _gsessiontimeout, _gposttimelimit, _gfinaldatabackuptime, _gclosesitecontent, _gisclosesite, _gisusersvariable, _gisshow, _giscomment, _gisshowcomment, _gispredown, _gisfriendlink, _gisrecommend, _giscorrelation, _gisonlineservice, _giskeywords, _gissqllog, _gisqrcode, _gishtmledit, _gishtmlmode, _gotherslistnums, _gproductslistnums, _garticleslistnums, _gnewslistnums, _gmesslistnums, _gmailaddress, _gmailname, _gmailsendemail, _gmailusername, _gmailuserpassword, _gforbiddenwords, _gsqlinword, _gbadwords, _glockip, _gsetuploadfiles, _gssinglesize, _gsmaxsize, _gsexe, _gwebtitlename, _gindexkeyword, _gindexdescription, _gindexcompanyintroduction, _gcompanyintroduction;
$(function () {
    // 定义全局变量
    $.ajax({
        type: 'post',
        url: 'getConfig.asp?Action=config',
        timeout: 15000,
        dataType: 'json',
        success: function (reponse) {
            _gwebsitename = reponse.websitename;
            _gwebsiteurl = reponse.websiteurl;
            _gtel = reponse.tel;
            _gmobiletel = reponse.mobiletel;
            _gfax = reponse.fax;
            _gqq = reponse.qq;
            _gmsn = reponse.msn;
            _gwebsiteemail = reponse.websiteemail;
            _gaddress = reponse.address;
            _gpostcode = reponse.postcode;
            _gwebsitemaster = reponse.websitemaster;
            _gwebsitemasteremail = reponse.websitemasteremail;
            _gwebsiteusers = reponse.websiteusers;
            _gwebsiteusersemail = reponse.websiteusersemail;
            _gtechnology = reponse.technology;
            _gtechnologyemail = reponse.technologyemail;
            _gcopyright = reponse.copyright;
            _gicp = reponse.icp;
            _gsitestatistics = reponse.sitestatistics;
            _gscripttimeout = reponse.scripttimeout;
            _gsessiontimeout = reponse.sessiontimeout;
            _gposttimelimit = reponse.posttimelimit;
            _gfinaldatabackuptime = reponse.finaldatabackuptime;
            _gclosesitecontent = reponse.closesitecontent;
            _gisclosesite = reponse.isclosesite;
            _gisusersvariable = reponse.isusersvariable;
            _gisshow = reponse.isshow;
            _giscomment = reponse.iscomment;
            _gisshowcomment = reponse.isshowcomment;
            _gispredown = reponse.ispredown;
            _gisfriendlink = reponse.isfriendlink;
            _gisrecommend = reponse.isrecommend;
            _giscorrelation = reponse.iscorrelation;
            _gisonlineservice = reponse.isonlineservice;
            _giskeywords = reponse.iskeywords;
            _gissqllog = reponse.issqllog;
            _gisqrcode = reponse.isqrcode;
            _gishtmledit = reponse.ishtmledit;
            _gishtmlmode = reponse.ishtmlmode;
            _gotherslistnums = reponse.otherslistnums;
            _gproductslistnums = reponse.productslistnums;
            _garticleslistnums = reponse.articleslistnums;
            _gnewslistnums = reponse.newslistnums;
            _gmesslistnums = reponse.messlistnums;
            _gmailaddress = reponse.mailaddress;
            _gmailname = reponse.mailname;
            _gmailsendemail = reponse.mailsendemail;
            _gmailusername = reponse.mailusername;
            _gmailuserpassword = reponse.mailuserpassword;
            _gforbiddenwords = reponse.forbiddenwords;
            _gsqlinword = reponse.sqlinword;
            _gbadwords = reponse.badwords;
            _glockip = reponse.lockip;
            _gsetuploadfiles = reponse.setuploadfiles;
            _gssinglesize = reponse.ssinglesize;
            _gsmaxsize = reponse.smaxsize;
            _gsexe = reponse.sexe;
            _gwebtitlename = reponse.webtitlename;
            _gindexkeyword = reponse.indexkeyword;
            _gindexdescription = reponse.indexdescription;
            _gindexcompanyintroduction = reponse.indexcompanyintroduction;
            _gcompanyintroduction = reponse.companyintroduction;
        },
        error: function (xhr, type, errorThrown) {
            $('body').html('加载失败！');
        }
    });
});