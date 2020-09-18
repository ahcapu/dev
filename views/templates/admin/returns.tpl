<div class="frank">
    <div class="container-header">
        <div class="frank-logo">
            <a href="#">Frank</a>
        </div>
        <div class="frank-shipping">
            <a href="{$shipping}" class="shipping-link">Shipping</a>
        </div>
        <div class="frank-returns">
            <a href="{$returns}" class="returns-link">Returns</a>
        </div>
        <div class="frank-chart">
            <a href="#"><i class="material-icons" id="settings">settings</i></a>
        </div>
        <div class="frank-settings">
            <a href="#"><i class="material-icons">assessment</i></a>
        </div>
    </div>

    <div class="container-fluid mid-header">
        <div class="row">
            <div class="col-sm-8" style="display: flex;">
                <button class="btn-search"><i class="material-icons" id="material-icon">search</i></button>
                <input type="text" id="txt-search" placeholder="name, tracking number, address.." onfocus="this.placeholder = ''" onblur="this.placeholder = 'name, tracking number, address..'" class="input-search">
            </div>
            <div class="col-sm-2" style="display: flex;">
                <button class="btn-new-shipment"><i class="material-icons" style="font-size: 14px; font-weight: bold;">add</i> New shipment</button>
            </div>
            <div class="col-sm-2" style="display: flex; padding-top: 12px;">
                <a href="#" class="upload-file upload">Upload file</a>
                <a href="#" class="upload-icon upload"><i style="font-size: 20px; color: #e07047; " class="material-icons">system_update_alt</i></a>
            </div>
        </div>
    </div>
    <div class="container-fluid tabs-container">
        <div class="buttonContainer">
            <button id="tab-btn1">Pending</button>
            <button id="tab-btn2">Shipped</button>
            <button id="tab-btn3">Cancelled</button>
        </div>
        <div  id="main" class="main-tab main-tab-active">
            <div class="tabPanel">
                <table class="tabPanelTable">
                    <thead>
                    <tr>
                        <th scope="col">Tracking number</th>
                        <th scope="col">Recipients</th>
                        <th scope="col">Transporters</th>
                        <th scope="col">Delivery dates</th>
                        <th scope="col">Status</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody id="search-pending">
                    {foreach $api_franks as $api_frank}
                        {if $api_frank['status'] === 'pending'}
                            <tr>
                                <td scope="col">{$api_frank['orderNumber']}</td>
                                <td scope="col">{$api_frank['contact']['name']}</td>
                                <td scope="col">{$api_frank['transporter']['firstName']}</td>
                                <td scope="col">{$api_frank['pickupDate']|date_format:"%m/%d/%Y"}</td>
                                <td scope="col">{$api_frank['dropoff']['country']}</td>
                                <td scope="col"><a href="{$orderDetails}" data-target="detail" data-id="{$api_frank['_id']}" class="pencil"><i class="material-icons" style="font-size: 20px">create</i></a></td>
                            </tr>
                        {/if}
                    {/foreach}
                    </tbody>
                </table>
            </div>
            <div class="tabPanel">
                <table class="tabPanelTable">
                    <thead>
                    <tr>
                        <th scope="col">Tracking number</th>
                        <th scope="col">Recipients</th>
                        <th scope="col">Transporters</th>
                        <th scope="col">Delivery dates</th>
                        <th scope="col">Status</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody id="search-shipped">
                    {foreach $api_franks as $api_frank}
                        {if $api_frank['status'] === 'delivered'}
                            <tr>
                                <td scope="col">{$api_frank['orderNumber']}</td>
                                <td scope="col">{$api_frank['contact']['name']}</td>
                                <td scope="col">{$api_frank['transporter']['firstName']}</td>
                                <td scope="col">{$api_frank['pickupDate']|date_format:"%m/%m/%Y"}</td>
                                <td scope="col">{$api_frank['dropoff']['country']}</td>
                                <td scope="col"><a href="#"><i class="material-icons" style="font-size: 20px">create</i></a></td>
                            </tr>
                        {/if}
                    {/foreach}
                    </tbody>
                </table>
            </div>
            <div class="tabPanel">
                <table class="tabPanelTable">
                    <thead>
                    <tr>
                        <th scope="col">Tracking number</th>
                        <th scope="col">Recipients</th>
                        <th scope="col">Transporters</th>
                        <th scope="col">Delivery dates</th>
                        <th scope="col">Status</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody id="search-cancelled">
                    {foreach $api_franks as $api_frank}
                        {if $api_frank['status'] === 'cancelled'}
                            <tr>
                                <td scope="col">{$api_frank['orderNumber']}</td>
                                <td scope="col">{$api_frank['contact']['name']}</td>
                                <td scope="col">{$api_frank['transporter']['firstName']}</td>
                                <td scope="col">{$api_frank['pickupDate']|date_format:"%m/%m/%Y"}</td>
                                <td scope="col">{$api_frank['dropoff']['country']}</td>
                                <td scope="col"><a href="#"><i class="material-icons" style="font-size: 20px">create</i></a></td>
                            </tr>
                        {/if}
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>