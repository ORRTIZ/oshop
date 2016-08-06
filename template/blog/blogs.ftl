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

<div id="browse-blogs" class="panel panel-default">
  <div class="panel-heading">
      <h3 class="panel-title">${uiLabelMap.ProductBrowseBlogs}</h3>
  </div>
  <div class="panel-body">
    <ul class="list-group">
      <#list blogs as blog>
        <li class="list-group-item">
          <a href="<@ofbizUrl>MainBlog?blogContentId=${blog.contentId}</@ofbizUrl>" class="browsecategorybutton">${blog.contentName!}</a>
        </li>
      </#list>
    </ul>
  </div>
</div>
