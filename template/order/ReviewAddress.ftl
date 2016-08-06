<#if orderItemShipGroups?has_content>
<div class="panel panel">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.OrderShippingInformation}</h3>
    </div>
    <div class="panel-body">
        <#-- shipping address -->
        <#assign groupIdx = 0>
        <#list orderItemShipGroups as shipGroup>
            <#if orderHeader?has_content>
                <#assign shippingAddress = shipGroup.getRelatedOne("PostalAddress", false)!>
                <#assign groupNumber = shipGroup.shipGroupSeqId!>
            <#else>
                <#assign shippingAddress = cart.getShippingAddress(groupIdx)!>
                <#assign groupNumber = groupIdx + 1>
            </#if>
            <#if shippingAddress?has_content>
                ${uiLabelMap.OrderDestination} [${groupNumber}]<br/>
                <#if shippingAddress.toName?has_content>${uiLabelMap.CommonTo}: ${shippingAddress.toName}<br/></#if>
                <#if shippingAddress.attnName?has_content>${uiLabelMap.PartyAddrAttnName}: ${shippingAddress.attnName}<br/></#if>
                ${shippingAddress.address1}</br>
                <#if shippingAddress.address2?has_content>${shippingAddress.address2}</#if>
                <#assign shippingStateGeo = (delegator.findOne("Geo", {"geoId", shippingAddress.stateProvinceGeoId!}, false))! />
                ${shippingAddress.city}<br/>
                ${shippingAddress.postalCode!}<br/>
                <#if shippingStateGeo?has_content>${shippingStateGeo.geoName!}<br/></#if>
                <#assign shippingCountryGeo = (delegator.findOne("Geo", {"geoId", shippingAddress.countryGeoId!}, false))! />
                <#if shippingCountryGeo?has_content>${shippingCountryGeo.geoName!}</#if>
            </#if>
            <br/><br/>
            ${uiLabelMap.OrderMethod}:
            <#if orderHeader?has_content>
                <#assign shipmentMethodType = shipGroup.getRelatedOne("ShipmentMethodType", false)!>
                <#assign carrierPartyId = shipGroup.carrierPartyId!>
            <#else>
                <#assign shipmentMethodType = cart.getShipmentMethodType(groupIdx)!>
                <#assign carrierPartyId = cart.getCarrierPartyId(groupIdx)!>
            </#if>
            <#if carrierPartyId?? && carrierPartyId != "_NA_">${carrierPartyId!}</#if>
            ${(shipmentMethodType.description)?default("N/A")}
            <#if shippingAccount??>${uiLabelMap.AccountingUseAccount}: ${shippingAccount}</#if>
            <ul>
                <#-- tracking number -->
                <#if trackingNumber?has_content || orderShipmentInfoSummaryList?has_content>
                    <li>
                        ${uiLabelMap.OrderTrackingNumber}
                        <#-- TODO: add links to UPS/FEDEX/etc based on carrier partyId  -->
                        <#if shipGroup.trackingNumber?has_content>
                            ${shipGroup.trackingNumber}
                        </#if>
                        <#if orderShipmentInfoSummaryList?has_content>
                            <#list orderShipmentInfoSummaryList as orderShipmentInfoSummary>
                                <#if (orderShipmentInfoSummaryList?size > 1)>${orderShipmentInfoSummary.shipmentPackageSeqId}: </#if>
                                Code: ${orderShipmentInfoSummary.trackingCode?default("[Not Yet Known]")}
                                <#if orderShipmentInfoSummary.boxNumber?has_content>${uiLabelMap.OrderBoxNumber}${orderShipmentInfoSummary.boxNumber}</#if>
                                <#if orderShipmentInfoSummary.carrierPartyId?has_content>(${uiLabelMap.ProductCarrier}: ${orderShipmentInfoSummary.carrierPartyId})</#if>
                            </#list>
                        </#if>
                    </li>
                </#if>
                <#-- splitting preference -->
                <#if orderHeader?has_content>
                    <#assign maySplit = shipGroup.maySplit?default("N")>
                <#else>
                    <#assign maySplit = cart.getMaySplit(groupIdx)?default("N")>
                </#if>
                <li>
                    ${uiLabelMap.OrderSplittingPreference}:
                    <#if maySplit?default("N") == "N">${uiLabelMap.OrderPleaseWaitUntilBeforeShipping}.</#if>
                    <#if maySplit?default("N") == "Y">${uiLabelMap.OrderPleaseShipItemsBecomeAvailable}.</#if>
                </li>
                <#-- shipping instructions -->
                <#if orderHeader?has_content>
                    <#assign shippingInstructions = shipGroup.shippingInstructions!>
                <#else>
                    <#assign shippingInstructions =  cart.getShippingInstructions(groupIdx)!>
                </#if>
                <#if shippingInstructions?has_content>
                    <li>
                        ${uiLabelMap.OrderInstructions}
                        ${shippingInstructions}
                    </li>
                </#if>
                <#-- gift settings -->
                <#if orderHeader?has_content>
                    <#assign isGift = shipGroup.isGift?default("N")>
                    <#assign giftMessage = shipGroup.giftMessage!>
                <#else>
                    <#assign isGift = cart.getIsGift(groupIdx)?default("N")>
                    <#assign giftMessage = cart.getGiftMessage(groupIdx)!>
                </#if>
                <#if productStore.showCheckoutGiftOptions! != "N">
                    <li>
                        ${uiLabelMap.OrderGift}?
                        <#if isGift?default("N") == "N">${uiLabelMap.OrderThisIsNotGift}.</#if>
                        <#if isGift?default("N") == "Y">${uiLabelMap.OrderThisIsGift}.</#if>
                    </li>
                    <#if giftMessage?has_content>
                        <li>
                            ${uiLabelMap.OrderGiftMessage}
                            ${giftMessage}
                        </li>
                    </#if>
                </#if>
                <#if shipGroup_has_next>
                </#if>
            </ul>
            <#assign groupIdx = groupIdx + 1>
        </#list><#-- end list of orderItemShipGroups -->
    </div>
</div>
</#if>