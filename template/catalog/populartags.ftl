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

<#if tagCloudList?has_content>
  <div id="populartags" class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.EcommerceTags}</h3>
    </div>
    <div class="panel-body">
      <#list tagCloudList as tagCloud>
          <a style="font-size: ${tagCloud.fontSize}pt;" href="<@ofbizUrl>tagsearch?SEARCH_STRING=${tagCloud.tag}&amp;keywordTypeId=KWT_TAG&amp;statusId=KW_APPROVED</@ofbizUrl>">${tagCloud.tag}</a>
      </#list>
    </div>
  </div>
</#if>
