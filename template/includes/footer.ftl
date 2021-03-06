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

<#assign nowTimestamp = Static["org.ofbiz.base.util.UtilDateTime"].nowTimestamp()>
<div class="col-md-12">
  <div class="footer">
    <div class="row">
        <div class="col-md-3">
            <#--
            ${screens.render("component://oshop/widget/CatalogScreens.xml#populartags")}
            -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Information</h3>
                </div>
                <div class="panel-body">
                    <a href="<@ofbizUrl>viewcontent?contentId=oshop_AboutUs</@ofbizUrl>">AboutUs</a><br/>
                    <a href="<@ofbizUrl>viewcontent?contentId=oshop_CustService</@ofbizUrl>">Customer Service</a><br/>
                    Advanced Search<br/>
                    <a href="<@ofbizUrl>viewcontent?contentId=oshop_Returns</@ofbizUrl>">Orders & Returns</a><br/>
                    <a href="<@ofbizUrl>viewcontent?contentId=oshop_Contact</@ofbizUrl>">Contact Us</a><br/>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Why buy from us?</h3>
                </div>
                <div class="panel-body">
                    <a href="<@ofbizUrl>viewcontent?contentId=oshop_AboutUs</@ofbizUrl>">AboutUs</a>!<br/>
                    <a href="<@ofbizUrl>viewcontent?contentId=oshop_CustService</@ofbizUrl>">Customer Service</a><br/>
                    <a href="<@ofbizUrl>viewcontent?contentId=oshop_Privacy</@ofbizUrl>">Privacy Policy</a><br/>
                    Site Map<br/>
                    Search terms<br/>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">My Account</h3>
                </div>
                <div class="panel-body">
                    Sign In<br/>
                    View Cart<br/>
                    My Wishlist<br/>
                    Track my Order<br/>
                    Help<br/>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Contact Us!</h3>
                </div>
                <div class="panel-body">
                    Our phone<br/>
                    Our address<br/>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">follow Us!</h3>
                </div>
                <div class="panel-body">
                    Our tweet account<br/>
                    Our facebook account<br/>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>

<script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover();
});
</script>