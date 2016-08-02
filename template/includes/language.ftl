<#--
(C) Copyright 2015 Somonar B.V.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.

 -->

<div id="choose-language" class="panel panel-default">
  <div class="panel-heading">
      <h3 class="panel-title">${uiLabelMap.CommonLanguageTitle}</h3>
  </div>
  <div class="panel-body">
    <form method="post" name="chooseLanguage" action="<@ofbizUrl>setSessionLocale</@ofbizUrl>">
      <select name="newLocale" class="selectBox" style="width:95%" onchange="submit()">
        <#assign availableLocales = Static["org.ofbiz.base.util.UtilMisc"].availableLocales()/>
        <#list availableLocales as availableLocale>
          <#assign langAttr = availableLocale.toString()?replace("_", "-")>
          <#assign langDir = "ltr">
          <#if "ar.iw"?contains(langAttr?substring(0, 2))>
            <#assign langDir = "rtl">
          </#if>
          <option lang="${langAttr}" dir="${langDir}" value="${availableLocale.toString()}"<#if locale.toString() = availableLocale.toString()> selected="selected"</#if>>${availableLocale.getDisplayName(availableLocale)}</option>
        </#list>
      </select>
    </form>
  </div>
</div>