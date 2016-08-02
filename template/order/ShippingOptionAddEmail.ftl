<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.PartyEmailAddresses}</h3>
    </div>
    <div class="panel-body">
        <table>
              <tr>
                <td colspan="2">
                  <div>${uiLabelMap.OrderEmailSentToFollowingAddresses}:</div>
                  <div>
                    <b>
                      <#list emailList as email>
                        ${email.infoString!}<#if email_has_next>,</#if>
                      </#list>
                    </b>
                  </div>
                  <div>${uiLabelMap.OrderUpdateEmailAddress} <a href="<@ofbizUrl>viewprofile?DONE_PAGE=checkoutoptions</@ofbizUrl>" class="buttontext">${uiLabelMap.PartyProfile}</a>.</div>
                  <br />
                  <div>${uiLabelMap.OrderCommaSeperatedEmailAddresses}:</div>
                  &nbsp;<input type="text" class="inputBox" size="30" name="order_additional_emails" value="${shoppingCart.getOrderAdditionalEmails()!}"/>
                </td>
              </tr>
        </table>
    </div>
</div>