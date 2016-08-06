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
<#-- Product Reviews -->
<div id="reviews">
    <div>${uiLabelMap.OrderCustomerReviews}:</div>
    <#if averageRating?? && (averageRating &gt; 0) && numRatings?? && (numRatings &gt; 1)>
        <div>${uiLabelMap.OrderAverageRating}: ${averageRating} <#if numRatings??>(${uiLabelMap.CommonFrom} ${numRatings} ${uiLabelMap.OrderRatings})</#if></div>
    </#if>
    <hr />
    <#if productReviews?has_content>
        <#list productReviews as productReview>
            <#assign postedUserLogin = productReview.getRelatedOne("UserLogin", false) />
            <#assign postedPerson = postedUserLogin.getRelatedOne("Person", false)! />
            <div><strong>${uiLabelMap.CommonBy}: </strong><#if productReview.postedAnonymous?default("N") == "Y"> ${uiLabelMap.OrderAnonymous}<#else> ${postedPerson.firstName} ${postedPerson.lastName}&nbsp;</#if></div>
            <div><strong>${uiLabelMap.CommonAt}: </strong>${productReview.postedDateTime!}&nbsp;</div>
            <div><strong>${uiLabelMap.OrderRanking}: </strong>${productReview.productRating!?string}</div>
            <div>&nbsp;</div>
            <div>${productReview.productReview!}</div>
            <hr />
        </#list>
        <div>
            <a href="<@ofbizUrl>reviewProduct?category_id=${categoryId!}&amp;product_id=${product.productId}</@ofbizUrl>" class="btn btn-warning btn-sm">${uiLabelMap.ProductReviewThisProduct}!</a>
        </div>
    <#else>
        <div>${uiLabelMap.ProductProductNotReviewedYet}.</div>
        <div>
            <a href="<@ofbizUrl>reviewProduct?category_id=${categoryId!}&amp;product_id=${product.productId}</@ofbizUrl>" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#myModal">
                ${uiLabelMap.ProductBeTheFirstToReviewThisProduct}
            </a>
        </div>
    </#if>
</div>
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Modal Header</h4>
      </div>
      <div class="modal-body">
        <p>Some text in the modal.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>