<!-- loyality points -->
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.EcommerceLoyaltyPoints}</h3>
    </div>
    <div class="panel-body">
        <#if monthsToInclude?? && totalSubRemainingAmount?? && totalOrders??>
            <label>${uiLabelMap.EcommerceYouHave} ${totalSubRemainingAmount} ${uiLabelMap.EcommercePointsFrom} ${totalOrders} ${uiLabelMap.EcommerceOrderInLast} ${monthsToInclude} ${uiLabelMap.EcommerceMonths}</label>
         </#if>
    </div>
</div>

