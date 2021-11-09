<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:cdp="http://www.hl7.org.tw/EMR/CDocumentPayload/v1.0" xmlns:n1="urn:hl7-org:v3" xmlns:n2="urn:hl7-org:v3/meta/voc" xmlns:n3="http://www.w3.org/1999/xhtml" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <xsl:output method="html" indent="yes" version="4.01" encoding="utf-8" doctype-public="-//W3C//DTD HTML 4.01//EN" />
  <xsl:template match="/">
    <xsl:apply-templates select="//n1:ClinicalDocument" />
  </xsl:template>
  <xsl:template match="//n1:ClinicalDocument">
    <xsl:variable name="title">
      <xsl:choose>
        <xsl:when test="//n1:ClinicalDocument/n1:title">
          <xsl:value-of select="//n1:ClinicalDocument/n1:title" />
        </xsl:when>
        <xsl:otherwise>王殿馨</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- 性別 -->
    <xsl:variable name="PatientSexValue">
      <xsl:choose>
        <xsl:when test="//n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:administrativeGenderCode/@code">
          <xsl:value-of select="//n1:ClinicalDocument/n1:recordTarget/n1:patientRole/n1:patient/n1:administrativeGenderCode/@code" />
        </xsl:when>
        <xsl:otherwise>U</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="PatientSexChineseName">
      <xsl:choose>
        <xsl:when test="$PatientSexValue='M'">男性</xsl:when>
        <xsl:when test="$PatientSexValue='F'">女性</xsl:when>
        <xsl:otherwise>未知或未設定</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- 機密等級 -->
    <xsl:variable name="ConfidentialLevelValue">
      <xsl:choose>
        <xsl:when test="//n1:ClinicalDocument/n1:confidentialityCode/@code">
          <xsl:value-of select="//n1:ClinicalDocument/n1:confidentialityCode/@code" />
        </xsl:when>
        <xsl:otherwise>U</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="ConfidentialLevelChineseName">
      <xsl:choose>
        <xsl:when test="$ConfidentialLevelValue='N'">普通</xsl:when>
        <xsl:when test="$ConfidentialLevelValue='R'">機密</xsl:when>
        <xsl:when test="$ConfidentialLevelValue='V'">極機密</xsl:when>
        <xsl:otherwise>未知或未設定</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--病人生活史-->
    <xsl:variable name="secSocialHistory" select="n1:component/n1:structuredBody/n1:component/n1:section[./n1:code[@code='29762-2' and @codeSystem='2.16.840.1.113883.6.1']]" />
    <style type="text/css">
      .TitleFonts {
      font-family:Arial,DFKai-sb;
      font-size:x-large;
      }
      .pre-style
      {
      font-family: Arial,DFKai-sb Helvetica, sans-serif, Courier New, Verdana;
      <!--text-align:left;-->
      font-size:16px;
      font-weight:normal;
      <!--vertical-algin:middle;-->
      white-space: pre-wrap;
      /*word-break: break-all;*/
      word-wrap: break-word;
      white-space: -moz-pre-wrap;
      }
      .SubTitleFont
      {
      font-family:DFKai-sb;
      font-size:18px;
      font-weight:bolder;
      margin-left: 3px;
      margin-top: 15px;
      margin-bottom: 15px;
      text-align: center;
      height:35px;
      }
      .ClsFontB{
      font-family:DFKai-sb;
      font-size:17px;
      }
      .column{
      text-align: center;
      font-weight: 700;
      }
      .InnerTD{
      <!--border: 2px double black;-->
      }
      .pre-style
      {
      font-family: Arial,DFKai-sb, Helvetica, sans-serif, Courier New, Verdana;
      <!--text-align:left;-->
      font-size:16px;
      font-weight:normal;
      <!--vertical-algin:middle;-->
      white-space: pre-wrap;
      /*word-break: break-all;*/
      word-wrap: break-word;
      }
      .Ddiv {
      table-layout: fixed;
      word-break: break-all;

      width: 740px;
      max-width:740px;
      }
    </style>
    <body>
      <xsl:variable name="secLabTestResult" select="n1:component/n1:structuredBody/n1:component/n1:section[./n1:code[@code='19146-0' and @codeSystem='2.16.840.1.113883.6.1']]" />
      <header>
        <!-- 表頭 start -->

        <br />
        <!--/////////////////////////////////////////////////////////////////-->
        <div  style="width:740px; margin: 0 auto;max-width:740px;">
          <table style="width: 720px; font-family: Arial,DFKai-sb;">
            <tbody>
              <tr>
                <td>
                  <table style="width: 100%; height: 100px; font-size: 16px;" border="0" cellspacing="0">
                    <tbody>
                      <tr>
                        <td colspan="8" align="center" height="50" style="font-size:35px;font-weight:bold;">
                          <xsl:value-of select="n1:recordTarget/n1:patientRole/n1:providerOrganization/n1:name"/>
                        </td>
                      </tr>
                      <tr>
                        <td colspan="8" align="center" height="50" style="font-size:28px;font-weight:bold;">
                          <xsl:value-of select="$title" />
                        </td>
                      </tr>
                      <tr>
                        <td width="115px" class="column">報告醫師:</td>
                        <td width="115px">
                          <xsl:call-template name="getName">
                            <xsl:with-param name="name" select="n1:author/n1:assignedAuthor/n1:assignedPerson/n1:name" />
                          </xsl:call-template>
                        </td>
                        <td width="115px" class="column">門診日期:</td>
                        <td>
                          <xsl:call-template name="formatDate">
                            <xsl:with-param name="date" select="n1:componentOf/n1:encompassingEncounter/n1:effectiveTime/@value" />
                          </xsl:call-template>
                        </td>
                        <td width="130px" class="column">報告時間:</td>
                        <td width="130px" colspan="2">
                          <xsl:call-template name="formatDate">
                            <xsl:with-param name="date" select="n1:effectiveTime/@value" />
                          </xsl:call-template>
                        </td>
                      </tr>
                      <tr>
                        <td width="115px" class="column">病歷號碼:</td>
                        <td width="115px">
                          <xsl:value-of select="n1:recordTarget/n1:patientRole/n1:id/@extension" />
                        </td>
                        <td width="115px" class="column">病患姓名:</td>
                        <td>
                          <xsl:call-template name="getName">
                            <xsl:with-param name="name" select="n1:recordTarget/n1:patientRole/n1:patient/n1:name" />
                          </xsl:call-template>
                        </td>
                        <td class="column">科別:</td>
                        <td width="115px">
                          <xsl:value-of select="n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:location/n1:name" />
                        </td>
                        <td width="65px" class="column">
                          身份:
                        </td>
                        <td width="115px">
                          <xsl:value-of select="$secSocialHistory/n1:component/n1:section[./n1:code[@code='63513-6' and @codeSystem='2.16.840.1.113883.6.1']]/n1:text" />
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr>
                <td></td>
              </tr>
            </tbody>
          </table>
        </div>
        <!-- 表頭 end -->
      </header>
      <Content>
        <div  style="width:740px; margin: 0 auto;max-width:740px;" class="Ddiv">
          <!--病人生活史 end-->
          <table border="1" cellpadding="1" cellspacing="1" width="100%" style=" font-family: Arial,DFKai-sb;">
            <tbody>
              <tr>
                <td colspan="6" class="SubTitleFont">
                  <strong>
                    <xsl:text>病人基本資料</xsl:text>
                  </strong>
                </td>
              </tr>
              <tr align="center">
                <td class="column">
                  <span>
                    <xsl:text>病歷號</xsl:text>
                  </span>
                </td>
                <td>
                  <xsl:for-each select="n1:recordTarget">
                    <xsl:for-each select="n1:patientRole">
                      <xsl:for-each select="n1:id">
                        <xsl:for-each select="@extension">
                          <span>
                            <xsl:value-of select="string(.)" />
                          </span>
                        </xsl:for-each>
                      </xsl:for-each>
                    </xsl:for-each>
                  </xsl:for-each>
                </td>
                <td class="column">
                  <span>
                    <xsl:text>姓名</xsl:text>
                  </span>
                </td>
                <td align="center">
                  <xsl:for-each select="n1:recordTarget">
                    <xsl:for-each select="n1:patientRole">
                      <xsl:for-each select="n1:patient">
                        <xsl:for-each select="n1:name">
                          <xsl:apply-templates />
                        </xsl:for-each>
                      </xsl:for-each>
                    </xsl:for-each>
                  </xsl:for-each>
                </td>
                <td class="column">
                  <span>
                    <xsl:text>出生日期</xsl:text>
                  </span>
                </td>
                <td align="center">
                  <xsl:for-each select="n1:recordTarget">
                    <xsl:for-each select="n1:patientRole">
                      <xsl:for-each select="n1:patient">
                        <xsl:for-each select="n1:birthTime">
                          <xsl:for-each select="@value">
                            <span>
                              <xsl:text> </xsl:text>
                            </span>
                            <span>
                              <xsl:value-of select="substring( . , 1 , 4 )" />
                            </span>
                            <span>
                              <xsl:text> 年  </xsl:text>
                            </span>
                            <span>
                              <xsl:value-of select="substring( . , 5 , 2 )" />
                            </span>
                            <span>
                              <xsl:text> 月  </xsl:text>
                            </span>
                            <span>
                              <xsl:value-of select="substring( . , 7 , 2 )" />
                            </span>
                            <span>
                              <xsl:text> 日</xsl:text>
                            </span>
                          </xsl:for-each>
                        </xsl:for-each>
                      </xsl:for-each>
                    </xsl:for-each>
                  </xsl:for-each>
                </td>
              </tr>
              <tr align="center">
                <td class="column">
                  <span>
                    <xsl:text>性別</xsl:text>
                  </span>
                </td>
                <td align="center">
                  <xsl:for-each select="n1:recordTarget">
                    <xsl:for-each select="n1:patientRole">
                      <xsl:for-each select="n1:patient">
                        <xsl:for-each select="n1:administrativeGenderCode">
                          <xsl:for-each select="@code">
                            <xsl:choose>
                              <xsl:when test=".='M'">
                                <span>
                                  <xsl:text>男</xsl:text>
                                </span>
                              </xsl:when>
                              <xsl:when test=".='F'">
                                <span>
                                  <xsl:text>女</xsl:text>
                                </span>
                              </xsl:when>
                              <xsl:otherwise>
                                <span>
                                  <xsl:text>未知</xsl:text>
                                </span>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:for-each>
                        </xsl:for-each>
                      </xsl:for-each>
                    </xsl:for-each>
                  </xsl:for-each>
                </td>
                <td class="column">
                  <span>
                    <xsl:text>身分證號</xsl:text>
                  </span>
                </td>
                <td align="center">
                  <xsl:for-each select="n1:recordTarget">
                    <xsl:for-each select="n1:patientRole">
                      <xsl:for-each select="n1:patient">
                        <xsl:for-each select="n1:id">
                          <xsl:for-each select="@extension">
                            <span>
                              <xsl:value-of select="string(.)" />
                            </span>
                          </xsl:for-each>
                        </xsl:for-each>
                      </xsl:for-each>
                    </xsl:for-each>
                  </xsl:for-each>
                </td>
                <td class="column">就診年齡:</td>
                <td colspan="3">
                  <xsl:call-template name="DisplayTextNode">
                    <xsl:with-param name="TextNode" select="$secSocialHistory/n1:component/n1:section[./n1:code[@code='29553-5' and @codeSystem='2.16.840.1.113883.6.1']]/n1:text" />
                  </xsl:call-template>
                </td>
              </tr>
              <tr style="height:22px;">
                <td class="column">
                  <span>
                    <xsl:text>血型</xsl:text>
                  </span>
                </td>
                <td colspan="3">
                  <xsl:call-template name="DisplayTextNode">
                    <xsl:with-param name="TextNode" select="$secLabTestResult/n1:component/n1:section[./n1:code[@code='883-9' and @codeSystem='2.16.840.1.113883.6.1']]/n1:text" />
                  </xsl:call-template>
                </td>
                <td class="column">D抗原性</td>
                <td colspan="3" style="padding-left:10px">
                  <xsl:value-of select="$secLabTestResult/n1:component/n1:section[./n1:code[@code='10331-7' and @codeSystem='2.16.840.1.113883.6.1']]/n1:code/@displayName" />
                  <xsl:value-of select="$secLabTestResult/n1:component/n1:section[./n1:code[@code='10331-7' and @codeSystem='2.16.840.1.113883.6.1']]/n1:text" />
                </td>
              </tr>
              <tr style="height:78px; ">
                <td class="column">
                  <span>
                    <xsl:text>過敏紀錄</xsl:text>
                  </span>
                </td>
                <td colspan="6" style="padding-left:10px">
                  <div class="pre-style" style="word-wrap:break-word; white-space: -moz-pre-wrap; max-width:740px; word-break: keep-all; ">
                    <xsl:call-template name="DisplayTextNode">
                      <xsl:with-param name="TextNode" select="n1:component/n1:structuredBody/n1:component/n1:section/n1:text[../n1:code[@code='10155-0' and @codeSystem='2.16.840.1.113883.6.1']]" />
                    </xsl:call-template>
                  </div>
                </td>
              </tr>
              <tr>
                <!--重大傷病-->
                <xsl:variable name="secHistoryMajorIllnessAndInjuries" select="n1:component/n1:structuredBody/n1:component/n1:section[./n1:code[@code='11338-1' and @codeSystem='2.16.840.1.113883.6.1']]" />
                <td class="column">重大傷病</td>
                <td colspan="6" style="padding-left:10px">
                  <div style="word-wrap:break-word; white-space: -moz-pre-wrap; max-width:740px; word-break: keep-all; ">
                    <ul>
                      <xsl:for-each select="$secHistoryMajorIllnessAndInjuries/n1:entry">
                        <li>
                          <xsl:choose>
                            <xsl:when test="n1:observation[@negationInd='true']">NA</xsl:when>
                            <xsl:otherwise>
                              (<xsl:value-of select="n1:observation/n1:code/@code" />) <xsl:value-of select="n1:observation/n1:code/@displayName" />
                            </xsl:otherwise>
                          </xsl:choose>
                        </li>
                      </xsl:for-each>
                    </ul>
                  </div>
                </td>
              </tr>
              <!--診斷-->
              <xsl:variable name="secDiagnosis" select="n1:component/n1:structuredBody/n1:component/n1:section[./n1:code[@code='29548-5' and @codeSystem='2.16.840.1.113883.6.1']]" />
              <tr>
                <td class="column">診斷</td>
                <td colspan="7" style="padding-left:10px">
                  <div style="word-wrap:break-word; white-space: -moz-pre-wrap; max-width:740px; word-break: keep-all; ">
                    <h4>
                      <xsl:value-of select="count($secDiagnosis/n1:entry)"/> 筆診斷，診斷比數剛好等於我的學號末兩碼「409570298」(´∀`)</h4>
                    <ul>
                      <xsl:for-each select="$secDiagnosis/n1:entry">
                        <li>
                          (<xsl:value-of select="n1:observation/n1:code/@code" />)
                          <xsl:value-of select="n1:observation/n1:code/@displayName" />
                        </li>
                      </xsl:for-each>
                    </ul>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
          <!--病情摘要 start-->
          <table border="1" cellpadding="1" cellspacing="1" width="100%" style=" font-family: Arial,DFKai-sb;">
            <xsl:variable name="secReturnVisitConditions" select="n1:component/n1:structuredBody/n1:component/n1:section[./n1:code[@code='19824-2' and @codeSystem='2.16.840.1.113883.6.1']]" />
            <tr>
              <td colspan="2" height="23" class="SubTitleFont">
                <strong>病情摘要</strong>
              </td>
            </tr>
            <tr>
              <td width="100" height="23" class="column">主觀描述</td>
              <td style="padding-left:10px">
                <div class="pre-style" style="word-wrap:break-word; white-space: -moz-pre-wrap; max-width:740px; word-break: keep-all; ">
                  <xsl:call-template name="DisplayTextNode">
                    <xsl:with-param name="TextNode" select="$secReturnVisitConditions/n1:component/n1:section[./n1:code[@code='61150-9' and @codeSystem='2.16.840.1.113883.6.1']]/n1:text" />
                  </xsl:call-template>
                </div>
              </td>
            </tr>
            <tr>
              <td width="100" height="23" class="column">客觀描述</td>
              <td style="padding-left:10px">
                <div class="pre-style" style="word-wrap:break-word; white-space: -moz-pre-wrap; max-width:740px; word-break: keep-all; ">
                  <xsl:call-template name="DisplayTextNode">
                    <xsl:with-param name="TextNode" select="$secReturnVisitConditions/n1:component/n1:section[./n1:code[@code='61149-1' and @codeSystem='2.16.840.1.113883.6.1']]/n1:text" />
                  </xsl:call-template>
                </div>
              </td>
            </tr>
            <tr>
              <td width="100" height="23" class="column">評估</td>
              <td style="padding-left:10px">
                <div class="pre-style" style="word-wrap:break-word; white-space: -moz-pre-wrap; max-width:740px; word-break: keep-all; ">
                  <xsl:call-template name="DisplayTextNode">
                    <xsl:with-param name="TextNode" select="$secReturnVisitConditions/n1:component/n1:section[./n1:code[@code='11494-2' and @codeSystem='2.16.840.1.113883.6.1']]/n1:text" />
                  </xsl:call-template>
                </div>
              </td>
            </tr>
          </table>
          <!--病情摘要 end-->
          <!--處置項目 start-->
          <xsl:variable name="secProcedure" select="n1:component/n1:structuredBody/n1:component/n1:section[./n1:code[@code='29554-3' and @codeSystem='2.16.840.1.113883.6.1']]" />
          <table border="1" cellpadding="1" cellspacing="1" style="width:740px; font-family: Arial,DFKai-sb;">
            <tr>
              <td colspan="6" height="23" Class="SubTitleFont">
                <strong>處置項目</strong>
              </td>
            </tr>
            <xsl:call-template name="ShowProcedureItems">
              <xsl:with-param name="secProcedure" select="$secProcedure" />
            </xsl:call-template>
          </table>
          <!--處置項目 end-->
          <!--處方-->
          <xsl:variable name="secPrescribe" select="n1:component/n1:structuredBody/n1:component/n1:section[./n1:code[@code='29551-9' and @codeSystem='2.16.840.1.113883.6.1']]" />
          <table border="1" cellpadding="1" cellspacing="1" style="width:740px; font-family: Arial,DFKai-sb;">
            <tr class="SubTitleFont">
              <td colspan="14" height="23" align="center">
                <strong>門診處方籤</strong>
              </td>
            </tr>
            <xsl:call-template name="ShowPrescribeItems">
              <xsl:with-param name="secPrescribe" select="$secPrescribe" />
            </xsl:call-template>
          </table>
        </div>
      </Content>
    </body>
  </xsl:template>
  <!--===========================================================================-->
  <xsl:template name="ShowProcedureItems">
    <xsl:param name="secProcedure" />
    <div style="font-family:'標楷體';font-size:18px;">
      <tr align="center">
        <td width="33" height="23">項次</td>
        <td width="90">處置代碼</td>
        <td width="250">處置名稱</td>
        <td width="85">頻率</td>
        <td width="95">數量(單位)</td>
        <!--<td width="90">部位</td>-->
        <td width="147">註記</td>
      </tr>
      <xsl:for-each select="$secProcedure/n1:entry">
        <xsl:choose>
          <xsl:when test="n1:procedure[@negationInd='true']">
            <tr>
              <td colspan="6" height="23" align="center">當次門診無開立處置紀錄</td>
            </tr>
          </xsl:when>
          <xsl:otherwise>
            <tr>
              <td align="center" height="23">
                <xsl:value-of select="n1:procedure/n1:id/@extension" />
              </td>
              <td style="text-align:center;">
                <xsl:value-of select="n1:procedure/n1:code/@code" />
              </td>
              <td>
                <xsl:value-of select="n1:procedure/n1:code/@displayName" />
              </td>
              <td style="text-align:center;">
                <xsl:value-of select="n1:procedure/n1:precondition/n1:criterion/n1:text" />
              </td>
              <td style="text-align:center;">
                <xsl:value-of select="n1:procedure/n1:precondition/n1:criterion/n1:value/@value" />
                (<xsl:value-of select="n1:procedure/n1:precondition/n1:criterion/n1:value/@unit" />)
              </td>
              <td>
                <xsl:value-of select="n1:procedure/n1:text" />
              </td>
            </tr>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </div>
  </xsl:template>
  <!--上半欄-->
  <xsl:template name="ShowPrescribeItems">
    <xsl:param name="secPrescribe" />
    <xsl:variable name="count" select="count($secPrescribe/n1:entry)" />

    <!--<div style="font-family:'標楷體';font-size:18px;">-->
    <tr style="text-align: center;">
      <td width="4%" height="23">
        項<br />次
      </td>
      <td width="14%" class="column">
        處方箋<br />種類<br />
      </td>
      <td width="14%" class="column">
        藥品<br />代碼
      </td>
      <td width="8%" class="column">劑型</td>
      <td width="8%" height="23" class="column">
        劑量
        <br />(單位)
      </td>
      <td width="8%" height="23" class="column">頻率</td>
      <td width="8%" class="column">
        給藥<br />途徑
      </td>
      <td width="4%" class="column">
        給<br />藥<br />日<br />數
      </td>
      <td width="8%" class="column">
        給藥<br />總量<br />(單位)
      </td>
      <td width="8%" class="column">
        實際<br />給藥<br />總量<br />(單位)
      </td>
      <td width="8%" class="column">
        磨粉<br />註記
      </td>
      <td width="8%" class="column">
        註 <br /> 記
      </td>
    </tr>
    <xsl:for-each select="$secPrescribe/n1:entry">
      <xsl:variable name="position" select="position()" />

      <xsl:choose>
        <xsl:when test="n1:substanceAdministration[@negationInd='true']">
          <tr style="text-align: center;">
            <td colspan="12" height="23" align="center">當次門診無開立處方用藥紀錄</td>
          </tr>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="supplyRQO" select="n1:substanceAdministration/n1:entryRelationship/n1:supply[@moodCode='RQO']" />
          <xsl:variable name="supplyPRP" select="n1:substanceAdministration/n1:entryRelationship/n1:supply[@moodCode='PRP']" />
          <xsl:variable name="act" select="n1:substanceAdministration/n1:entryRelationship/n1:act[@classCode='ACT']" />
          <tr align="center">
            <td width="4%" height="23" class="InnerTD">
              <!--項次-->
              <xsl:value-of select="n1:substanceAdministration/n1:id/@extension" />
            </td>
            <td width="14%" class="InnerTD">
              <!--處方箋種類註記-->
              <xsl:value-of select="$supplyPRP/n1:code/@displayName" />
            </td>
            <td width="14%" class="InnerTD">
              <!--藥品代碼-->
              <xsl:value-of select="n1:substanceAdministration/n1:code/@code" />
            </td>
            <td width="8%" class="InnerTD">
              <!--劑型-->
              <xsl:value-of select="n1:substanceAdministration/n1:administrationUnitCode/@displayName" />
            </td>
            <td width="8%" class="InnerTD">
              <!-->劑量(單位)--><xsl:value-of select="n1:substanceAdministration/n1:doseQuantity/@value" /><br></br>
              (<xsl:value-of select="n1:substanceAdministration/n1:doseQuantity/@unit" />)
            </td>
            <td width="8%" class="InnerTD">
              <!--頻率-->
              <xsl:value-of select="$act/n1:text" />
            </td>
            <td width="8%" class="InnerTD">
              <!--給藥途徑-->
              <xsl:value-of select="n1:substanceAdministration/n1:routeCode/@displayName" />
            </td>
            <td width="4%" class="InnerTD">
              <!--給藥日數-->
              <xsl:value-of select="n1:substanceAdministration/n1:repeatNumber/@value" />
            </td>
            <td width="8%" class="InnerTD">
              <!--給藥總量(單位)--><xsl:value-of select="$supplyPRP/n1:quantity/@value" /><br></br>
              (<xsl:value-of select="$supplyPRP/n1:quantity/@unit" />)
            </td>
            <td width="8%" class="InnerTD">
              <!--實際給藥總量(單位)--><xsl:value-of select="$supplyRQO/n1:quantity/@value" /><br></br>
              (<xsl:value-of select="$supplyRQO/n1:quantity/@unit" />)
            </td>
            <td width="8%" class="InnerTD">
              <!--磨粉註記-->
              <xsl:value-of select="$supplyRQO/n1:text" />
            </td>
            <td width="8%" class="InnerTD">
              <!--註記-->
              <xsl:value-of select="n1:substanceAdministration/n1:text" />
            </td>
          </tr>
          <tr style="text-align: center;">
            <td colspan="2" class="column">藥品商品名稱</td>
            <td colspan="4">
              <!--藥品商品名稱-->
              <xsl:value-of select="n1:substanceAdministration/n1:consumable/n1:manufacturedProduct/n1:manufacturedLabeledDrug/n1:name" />
            </td>
            <td colspan="2" class="column">藥品學名</td>
            <td colspan="4">
              <xsl:value-of select="$supplyRQO/n1:product/n1:manufacturedProduct/n1:manufacturedMaterial/n1:name" />
            </td>
          </tr>
          <xsl:if test="$position &lt; $count">
            <tr>
              <td colspan="12" height="23">
              </td>
            </tr>
          </xsl:if>

        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <!--</div>-->
  </xsl:template>
  <!-- 函式(templates) -->
  <!-- Get a Name  -->
  <xsl:template name="getName">
    <xsl:param name="name" />
    <xsl:choose>
      <xsl:when test="$name/n1:family">
        <xsl:value-of select="$name/n1:given" />
        <xsl:text></xsl:text>
        <xsl:value-of select="$name/n1:family" />
        <xsl:text></xsl:text>
        <xsl:if test="$name/n1:suffix">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="$name/n1:suffix" />
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$name" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- 顯示Code + displayName  -->
  <xsl:template name="getCodeAndName">
    <xsl:param name="TargetNode" /><xsl:value-of select="$TargetNode/@displayName" />
    (<xsl:value-of select="$TargetNode/@code" />)
  </xsl:template>
  <!--時間格式轉換 參數：date：傳入之時間-->
  <xsl:template name="formatDate">
    <xsl:param name="date" />
    <xsl:variable name="aYear" select="substring($date,1,4)" />
    <xsl:variable name="aMonth" select="substring($date,5,2)" />
    <xsl:variable name="aDay" select="substring($date,7,2)" />
    <xsl:variable name="aHour" select="substring($date,9,2)" />
    <xsl:variable name="aMin" select="substring($date,11,2)" />
    <xsl:variable name="aSec" select="substring($date,13,2)" />
    <xsl:if test="$aYear != ''">
      <xsl:value-of select="$aYear" />
      <xsl:if test="$aMonth != ''">
        <xsl:text>/</xsl:text>
        <xsl:value-of select="$aMonth" />
        <xsl:if test="$aDay != ''">
          <xsl:text>/</xsl:text>
          <xsl:value-of select="$aDay" />
          <xsl:if test="$aHour != ''">
            <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;</xsl:text>
            <xsl:value-of select="$aHour" />
            <xsl:if test="$aMin != ''">
              <xsl:text>:</xsl:text>
              <xsl:value-of select="$aMin" />
              <xsl:if test="$aSec != ''">
                <xsl:text>:</xsl:text>
                <xsl:value-of select="$aSec" />
              </xsl:if>
            </xsl:if>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <!--paragraph-->
  <xsl:template match="n1:paragraph">
    <xsl:apply-templates />
    <br />
  </xsl:template>
  <!--New template by Phil-->
  <!-- 顯示Code + displayName  -->
  <xsl:template name="DisplayICDEntries">
    <xsl:param name="TargetSection" />
    <xsl:choose>
      <xsl:when test="$TargetSection/n1:entry">
        <ul>
          <xsl:for-each select="$TargetSection/n1:entry">
            <xsl:choose>
              <xsl:when test="n1:observation/n1:code[@codeSystem='2.16.840.1.113883.6.2']">
                <li>
                  <xsl:value-of select="n1:observation/n1:code/@displayName" />(<xsl:value-of select="n1:observation/n1:code/@code" />)
                </li>
              </xsl:when>
            </xsl:choose>
          </xsl:for-each>
        </ul>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- 顯示 Body part  -->
  <xsl:template name="DisplayBodyParts">
    <xsl:param name="structuredBody" />
    <xsl:choose>
      <xsl:when test="$structuredBody">
        <xsl:for-each select="$structuredBody/n1:component/n1:section[./n1:code[@code='55286-9' and @codeSystem='2.16.840.1.113883.6.1']]">
          <span style="padding-right:3px">
            <xsl:value-of select="./n1:text" />
          </span>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="." />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="InsertBreaks">
    <xsl:param name="pText" />
    <xsl:choose>
      <xsl:when test="not(contains($pText, '&#xA;'))">
        <xsl:copy-of select="$pText" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring-before($pText, '&#xA;')" />
        <br />
        <xsl:call-template name="InsertBreaks">
          <xsl:with-param name="pText" select="substring-after($pText, '&#xA;')" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- 顯示 Text node  In paragraph-->
  <xsl:template name="DisplayTextNode">
    <xsl:param name="TextNode" />
    <xsl:choose>
      <xsl:when test="$TextNode/n1:paragraph">
        <xsl:for-each select="$TextNode/n1:paragraph">
          <div class="pre-style">
            <xsl:value-of select="." />
          </div>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <div class="pre-style">
          <xsl:value-of select="$TextNode" />
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- 顯示 Text node  -->
  <xsl:template name="DisplayTextNodeInline">
    <xsl:param name="TextNode" />
    <xsl:choose>
      <xsl:when test="$TextNode/n1:paragraph">
        <xsl:for-each select="$TextNode/n1:paragraph">
          <span>
            <xsl:value-of select="." />
          </span>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$TextNode" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--Display Images-->
  <xsl:template name="DisplayImageEntry">
    <xsl:param name="ImageEntry" />
    <xsl:choose>
      <xsl:when test="$ImageEntry/n1:observationMedia">
        <xsl:for-each select="$ImageEntry/n1:observationMedia">
          <img>
            <xsl:attribute name="src">
              data:<xsl:value-of select="./n1:value/@mediaType" />;base64,<xsl:value-of select="./n1:value" />
            </xsl:attribute>
          </img>
        </xsl:for-each>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>