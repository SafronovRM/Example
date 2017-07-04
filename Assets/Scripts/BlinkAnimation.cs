using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

enum ImageType
{
	ImageUI,
	Sprite
}

public class BlinkAnimation : MonoBehaviour
{
	[SerializeField]private float _speed = 5;
	[SerializeField]private ImageType _type;
	private Material _material;
	private float _positionX;
	private Transform _transform;
	private Vector3 _originalScale;
	private bool _isAnimate;
	// Use this for initialization
	void Start ()
	{
		if (_type == ImageType.Sprite)
			_material = GetComponent<Renderer>().material;
		else
			_material = GetComponent<Image>().material;
		_positionX = 1.0f;
		_material.SetTextureOffset("_BlinkTex", new Vector2(_positionX, 0));
	}
	
	// Update is called once per frame
	void Update ()
	{ 
		_positionX -= _speed * Time.deltaTime;
		_material.SetTextureOffset("_BlinkTex", new Vector2(_positionX, 0));
		if (_positionX < -1)
		{
			_positionX = 1.0f;
		}
	}


}
