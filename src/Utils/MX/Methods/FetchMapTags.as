namespace MX
{
    void FetchMapTags()
    {
        m_mapTags.RemoveRange(0, m_mapTags.Length);
        APIRefreshing = true;

        Json::Value resNet = API::GetAsync(PluginSettings::RMC_MX_Url+"/api/tags/gettags");

        try {
            for (uint i = 0; i < resNet.get_Length(); i++)
            {
                int tagID = resNet[i]["ID"];
                string tagName = resNet[i]["Name"];

                if (IS_DEV_MODE) Log::Trace("Loading tag #"+tagID+" - "+tagName);

                m_mapTags.InsertLast(MapTag(resNet[i]));
            }

            print(m_mapTags.get_Length() + " tags loaded");
            APIDown = false;
            APIRefreshing = false;
        } catch {
            Log::Warn("Error while loading tags");
            Log::Error(MX_NAME + " API is not responding, it might be down.", true);
            APIDown = true;
            APIRefreshing = false;
        }
    }
}