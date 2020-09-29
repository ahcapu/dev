<?php

class AdminFrankSettingsController extends ModuleAdminController
{
    private $frank_api = null;

    public function __construct()
    {
        include_once _PS_MODULE_DIR_ . 'frank/api/FrankApi.php';

        $this->name = 'Frank';
        $this->display = 'view';
        $this->meta_title = 'Settings';
        $this->bootstrap = true;

        parent::__construct();
        $this->frank_api = new FrankApi();

        if (!$this->module->active)
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminFrankShipping'));
    }

    public function init()
    {
        parent::init();
    }

    public function initContent()
    {
        $api_email_addresses = json_decode($this->frank_api->getRequests('https://p-post.herokuapp.com/api/v1/stores/myprofile/' . Configuration::get('FRANK_ID'), Configuration::get('FRANK_TOKEN')), true);
        $shipping = $this->get_ahref('AdminFrankShipping');
        $returns = $this->get_ahref('AdminFrankReturns');
//        $new_shipment = $this->get_ahref('AdminFrankNewShipment');
        $settings = $this->get_ahref('AdminFrankSettings');
        parent::initContent();
        $this->context->smarty->assign(
            array(
                'api_email_addresses' => $api_email_addresses['data']['emailAddresses'],
                'shipping' => $shipping,
                'returns' => $returns,
                'settings' => $settings
            )
        );

        $this->setTemplate('settings.tpl');

    }

    public function setMedia($isNewTheme = false)
    {
        $this->addJquery();
        $this->addCSS(_PS_MODULE_DIR_ . '/frank/views/css/admin/bootstrap.css');
        $this->addCSS(_PS_MODULE_DIR_ . '/frank/views/css/admin/all.css');
        $this->addCSS(_PS_MODULE_DIR_ . '/frank/views/css/admin/settings.css');
        $this->addJS(_PS_MODULE_DIR_ . '/frank/views/js/admin/all.js');
        $this->addJS(_PS_MODULE_DIR_ . '/frank/views/js/admin/settings.js');
        parent::setMedia();
    }

    private function get_ahref($controller){
        $stat = _PS_ADMIN_DIR_;
        $admin_folder = substr(strrchr($stat, "admin "), 0);
        $token = Tools::getAdminTokenLite($controller);
        return _PS_BASE_URL_.__PS_BASE_URI__.$admin_folder.'/index.php?controller='.$controller.'&token='.$token;
    }
}