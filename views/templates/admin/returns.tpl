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
            <a href="{$settings}"><i class="material-icons" id="settings">settings</i></a>
        </div>
        <div class="frank-settings">
            <a href="#"><i class="material-icons">assessment</i></a>
        </div>
    </div>

    <div id="main-page-id" class="container-main-page container-main-page-active">
        <div class="container-fluid mid-header">
            <div class="row">
                <div class="col-sm-8" style="display: flex;">
                    <button class="btn-search"><i class="material-icons" id="material-icon" style="color: #e07047; ">search</i></button>
                    <input type="text" id="txt-search" placeholder="name, tracking number, address.." onfocus="this.placeholder = ''" onblur="this.placeholder = 'name, tracking number, address..'" class="input-search">
                </div>
                <div class="col-sm-2" style="display: flex;">
                    <button class="btn-new-shipment" onclick="window.location.href = '{$new_shipment}';"><i class="material-icons" style="font-size: 14px; font-weight: bold;">add</i> New shipment</button>
                </div>
                <div class="col-sm-2" style="display: flex; padding-top: 12px;">
                    <a href="#" class="upload-icon upload"><i style="font-size: 20px; color: #e07047; " class="material-icons">system_update_alt</i></a>
                    <a href="#" class="upload-file upload">Upload file</a>
                </div>
            </div>
        </div>
        <div class="container-fluid tabs-container">
            <div class="buttonContainer">
                <button id="tab-btn1">Pending</button>
                <button id="tab-btn2">Shipped</button>
                <button id="tab-btn3">Cancelled</button>
            </div>
            <div class="main-tab">
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
                                    <td scope="col">
                                        <a href="{$orderDetails}" data-target="detail" data-id="{$api_frank['_id']}" class="pencil">
                                            <i class="material-icons" style="font-size: 20px; ">create</i>
                                        </a>
                                    </td>
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

    <div id="upload-page-id" class="container-upload-page">
        <div class="container-fluid" style="margin-top: 40px;">
            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-6" style=" height: 400px; background-color: white;border-radius: 9px; padding: 30px;">
                    <div class="row">
                        <div class="col-sm-11"></div>
                        <div class="col-sm-1">
                            <button class="upload-cancel-btn" style="background-color: unset; border: unset; color: #e07047; font-size: 25px;">X</button>
                        </div>
                    </div>
                    <div class="row" style="padding-top: 80px;">
                        <div class="col-sm-4"></div>
                        <div class="col-sm-4 text-center"><span class="material-icons" style="color: #e07047; font-size: 50px;">cloud_download</span></div>
                        <div class="col-sm-4"></div>
                    </div>
                    <div class="row">
                        <div class="col-sm-3"></div>
                        <div class="col-sm-6 text-center">
                            <p>Drag and drop your excel file here</p>
                        </div>
                        <div class="col-sm-3"></div>
                    </div>
                    <form method="post" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-sm-3"></div>
                            <div class="col-sm-6 text-center">
                                <input type="file" name="file">
                            </div>
                            <div class="col-sm-3">
                                <input type="submit" name="import_csv_btn" value="Import">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-sm-3"></div>
            </div>
        </div>
    </div>

</div>