using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ShaderLib {
    [RequireComponent(typeof(Camera))]
    public class ImageEffectBase : MonoBehaviour {

        [HideInInspector] protected Material material;
        //protected Material material;


        protected void Start()
        {
            if (!this.material || !this.material.shader.isSupported)
            {
                base.enabled = false;
            }
        }

        protected bool IsSupportAndEnable () {
            return material != null && material.shader.isSupported;
        }
    }
}