package me.haima.ane
{
	public class HaimaEvent
	{
		public function HaimaEvent()
		{
		}
		
		/**
		 * 支付成功(注意有可能是验签失败[VerifyFail]) 
		 */		
		public static const IPAY_PAYMENT_SUCCESS:String = "IPAY_PAYMENT_SUCCESS";
		/**
		 * 支付取消 
		 */		
		public static const IPAY_PAYMENT_CANCELED:String = "IPAY_PAYMENT_CANCELED";
		/**
		 * 支付失败 
		 */		
		public static const IPAY_PAYMENT_FAILED:String = "IPAY_PAYMENT_FAILED";
		/**
		 * 登陆成功 
		 */		
		public static const IPAY_LOGIN_SUCCESS:String = "IPAY_LOGIN_SUCCESS";
	}
}