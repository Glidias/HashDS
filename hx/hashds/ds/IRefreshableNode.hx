package hashds.ds;

/**
 * ...
 * @author Glidias
 */

interface IRefreshableNode implements IRefreshable
{
	
	function nextRefresh():IRefreshableNode;
	
}