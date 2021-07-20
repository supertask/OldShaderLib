using UnityEngine;

#if UNITY_EDITOR
using UnityEditor;
#endif

using System.IO;
using System.Collections;

namespace ShaderLib.Examples
{
#if UNITY_EDITOR
    [CustomEditor(typeof(PhotoshopImageEffect))]
    public class PhotoshopImageEffectEditor : Editor {

        public override void OnInspectorGUI() 
        {
            EditorGUI.BeginChangeCheck();
            base.OnInspectorGUI();

            PhotoshopImageEffect photoshopIE = target as PhotoshopImageEffect;

            if (EditorGUI.EndChangeCheck())
            {
                //Debug.Log("end change ");
                this.serializedObject.ApplyModifiedProperties();
                photoshopIE.EnableKeyword();
            }
        }

    }
#endif
}
