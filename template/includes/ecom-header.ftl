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
    <div id="left" class="col-md-3 text-center">
        <#if sessionAttributes.overrideLogo??>
            <img src="<@ofbizContentUrl>${sessionAttributes.overrideLogo}</@ofbizContentUrl>" alt="Logo"/>
        <#elseif catalogHeaderLogo??>
            <img src="<@ofbizContentUrl>${catalogHeaderLogo}</@ofbizContentUrl>" alt="Logo"/>
        <#elseif layoutSettings.VT_HDR_IMAGE_URL?has_content>
            <img src="<@ofbizContentUrl>${layoutSettings.VT_HDR_IMAGE_URL.get(0)}</@ofbizContentUrl>" alt="Logo"/>
        </#if>
    </div>
    <div id="middle" class="col-md-4 text-center">
        <#if !productStore??>
            <h2>${uiLabelMap.EcommerceNoProductStore}</h2>
        </#if>
        <#if (productStore.title)??><div id="company-name">${productStore.title}</div></#if>
        <#if (productStore.subtitle)??><div id="company-subtitle">${productStore.subtitle}</div></#if>
        <div id="welcome-message">
            <#if sessionAttributes.autoName?has_content>
                ${uiLabelMap.CommonWelcome}&nbsp;<strong>${sessionAttributes.autoName?html}!</strong>
                (${uiLabelMap.CommonNotYou}?&nbsp;<a href="<@ofbizUrl>autoLogout</@ofbizUrl>" class="linktext">${uiLabelMap.CommonClickHere}</a>)
            <#else/>
                ${uiLabelMap.CommonWelcome}!
            </#if>
        </div>
    </div>
    <div id="right" class="col-md-5 text-right">
        <ul id="left-links" class="nav navbar-nav navbar-right" role="tablist">
            <#if userLogin?has_content && userLogin.userLoginId != "anonymous">
            <#include "../customer/MyAccountMenu.ftl" />
            <li id="header-bar-logout"><a href="<@ofbizUrl>logout</@ofbizUrl>">${uiLabelMap.CommonLogout}</a></li>
            <#else/>
                <li><a href="<@ofbizUrl>viewprofile</@ofbizUrl>">${uiLabelMap.EcommerceMyAccount}</a></li>
            </#if>
            <li id="header-bar-contactus">
                <#if userLogin?has_content && userLogin.userLoginId != "anonymous">
                    <a href="<@ofbizUrl>contactus</@ofbizUrl>">${uiLabelMap.CommonContactUs}</a>
                <#else>
                    <a href="<@ofbizUrl>AnonContactus</@ofbizUrl>">${uiLabelMap.CommonContactUs}</a>
                </#if>
            </li>
            <li id="header-bar-language" class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">${uiLabelMap.CommonLanguageTitle} <span class="caret"></a>
                <div class="dropdown-menu">
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
            </li>
        </ul>
    </div>