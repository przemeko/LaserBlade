package com.kocznur.utils 
{
	/**
	 * ...
	 * @author pkocznur
	 */
	public class Filter 
	{
		
		public function Filter() 
		{
			
		}
		
		/**
		 * add
		 * 
		 * Does not allow to exceed maxValue
		 * 
		 * @param	value
		 * @param	addValue
		 * @param	maxValue
		 * @return
		 */
		public static function add(value:Number, addValue:Number, maxValue:Number):Number
		{
			if (addValue > 0)
			{
				if (value >= maxValue || value + addValue >= maxValue)
				{
					return maxValue;
				}
			}
			else 
			{
				if (value <= maxValue || value + addValue <= maxValue)
				{
					return maxValue;
				}
			}
			
			return value + addValue;
		}
		
	}

}