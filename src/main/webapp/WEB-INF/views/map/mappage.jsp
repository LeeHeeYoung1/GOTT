<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>   
<!DOCTYPE html>

<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=ea87fc26ee3f75472cb75c454c18b302&libraries=services"></script>

<style>

	.mapContainer {
		width: 100%;
	    height: 750px;
	    border: 1px solid #cbd5e1;
	    border-radius: 12px;
	    margin: 0;
	    overflow: hidden;
	}
	.mapTitle {
        margin-bottom: 20px;
    }

    .mapDescription {
        margin-bottom: 20px;
        color: #64748b;
        font-size: 14px;
    }

    .mapToolbar {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-bottom: 15px;
    }

    .mapToolbar button {
        padding: 10px 16px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        background: #fff;
        color: #263238;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .mapToolbar button:hover:not(:disabled) {
        background: #e2e8f0;
    }

    .mapToolbar button:disabled {
        opacity: 0.5;
        cursor: not-allowed;
    }

    .mapStatus {
        margin-bottom: 10px;
        color: #475569;
        font-size: 14px;
    }
	.mapFrame {
	   	position: relative;
	    width: 80%;
	    margin: 0 auto;
	}
    .mapSearch {
        display: flex;
        gap: 8px;
        margin-bottom: 15px;
    }

    .mapSearch input {
        flex: 1;
        min-width: 0;
        padding: 11px 14px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        outline: none;
        font-size: 14px;
    }

    .mapSearch input:focus {
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
    }

    .mapSearch button {
        padding: 10px 20px;
        border: none;
        border-radius: 6px;
        background-color: #2563eb;
        color: white;
        font-size: 14px;
        cursor: pointer;
    }

    .mapSearch button:hover {
        background-color: #1d4ed8;
    }
    .searchInputWrap {
        position: relative;
        flex: 1;
        min-width: 0;
    }

    .searchInputWrap input {
        width: 100%;
    }
    .mapOverlay {
	    position: absolute;
	    top: 20px;
	    left: 20px;
	    z-index: 10;
	
	    width: 360px;
	    max-width: calc(100% - 40px);
	    padding: 14px;
	
	    box-sizing: border-box;
	    background: transparent;
	    border-radius: 12px;
	    border: none;
		box-shadow: none;
	}
	
	/* 검색창 내부 정렬 */
	.mapOverlay .mapSearch {
	    display: flex;
	    gap: 8px;
	    margin-bottom: 10px;
	}
	
	.mapOverlay .mapSearch input,
	.placeSearch input {
	    box-sizing: border-box;
	    width: 100%;
	    min-width: 0;
	    padding: 11px;
	
	    border: 1px solid #cbd5e1;
	    border-radius: 6px;
	    outline: none;
	}
	
	.mapOverlay input:focus {
	    border-color: #2563eb;
	}
	
	/* 지역 검색 버튼 */
	.mapOverlay .mapSearch button {
	    flex-shrink: 0;
	    padding: 10px 12px;
	
	    border: none;
	    border-radius: 6px;
	    background: #64748b;
	    color: #fff;
	    cursor: pointer;
	}
	.placeSearch {
	    display: flex;
	    gap: 8px;
	}
	
	.placeSearch button {
	    flex-shrink: 0;
	    padding: 10px 14px;
	
	    border: none;
	    border-radius: 6px;
	    background: #2563eb;
	    color: #fff;
	    cursor: pointer;
	}
	
	/* 장소 검색 결과 목록 */
	#placeSearchResults {
	    max-height: 300px;
	    margin-top: 8px;
	    overflow-y: auto;
	}
	
	.placeSearchResult {
	    padding: 11px 6px;
	    border-bottom: 1px solid #e2e8f0;
	    cursor: pointer;
	}
	
	
	.placeSearchResult:hover {
	    background: #eff6ff;
	}
	
	.placeSearchResult strong {
	    display: block;
	    font-size: 14px;
	}
	
	.placeSearchResult span {
	    display: block;
	    margin-top: 4px;
	    color: #64748b;
	    font-size: 12px;
	}
	.placeAutocompleteItem strong {
	    display: block;
	    font-size: 14px;
	}
	
	.placeAutocompleteItem span {
	    display: block;
	    margin-top: 4px;
	    color: #64748b;
	    font-size: 12px;
	}
	
	.placeAutocompleteMessage {
	    padding: 12px 8px;
	    color: #64748b;
	    font-size: 13px;
	}

    /* 자동완성 목록 */
    .autocompleteList {
        position: absolute;
        top: calc(100% + 6px);
        left: 0;
        right: 0;

        z-index: 1000;
        max-height: 280px;
        overflow-y: auto;

        background-color: #ffffff;
        border: 1px solid #cbd5e1;
        border-radius: 8px;
        box-shadow: 0 8px 24px rgba(15, 23, 42, 0.12);
    }

    /* 후보 하나 */
    .autocompleteList button {
        display: block;
        width: 100%;
        padding: 11px 14px;

        border: none;
        border-radius: 0;
        background-color: #ffffff;
        color: #263238;

        text-align: left;
        cursor: pointer;
    }

    /* 후보에 마우스를 올리거나 키보드로 선택했을 때 */
    .autocompleteList button:hover,
    .autocompleteList button.active {
        background-color: #eff6ff;
    }

    /* 후보의 지역명 */
    .autocompleteName {
        display: block;
        font-size: 14px;
        font-weight: 600;
    }

    /* 후보의 지역 종류 */
    .autocompleteType {
        display: block;
        margin-top: 2px;
        color: #64748b;
        font-size: 12px;
    }

    /* 검색 결과가 없을 때 */
    .autocompleteEmpty {
        padding: 12px 14px;
        color: #64748b;
        font-size: 13px;
    }

    /* hidden 속성이 다른 CSS에 의해 무시되지 않도록 처리 */
    .autocompleteList[hidden] {
        display: none;
    }

    @media (max-width: 768px) {
    .mapFrame {
        width: 100%;
    }

    .mapContainer {
        height: 500px;
    }

    .mapOverlay {
        top: 10px;
        left: 10px;
        width: 360px;
        max-width: calc(100% - 20px);
        padding: 10px;
    }
}
</style>

	<div class="container">
		<div class="mapPage">

	    	<h2 class="mapTitle" style="text-align: center;">지역별 여행 지도</h2>
	
	    <p class="mapDescription" style="text-align: center;">
	        지도에서 시·도를 선택해 보세요.
	    </p>
	
	    <div class="mapToolbar flex-center">
	        <button type="button" id="showProvincesBtn">
	            전국 보기
	        </button>
	
	        <button type="button" id="showDistrictsBtn" disabled>
	            시·군·구 보기
	        </button>
	
	        <button type="button" id="resetMapBtn">
	            지도 초기화
	        </button>
	    </div>
	
	    <div id="mapStatus" class="mapStatus" style="text-align: center;">
	        지도를 불러오는 중입니다.
	    </div>
	
	    <div class="mapFrame">

	    <!-- 지도 위 검색창 -->
	    <div class="mapOverlay">
	
	        <!-- 기존 지역 검색 -->
	        <div class="mapSearch">
	            <div class="searchInputWrap">
	                <input type="text" id="regionSearchInput" placeholder="지역 검색 (예: 서울, 종로구)"
	                    autocomplete="off" aria-label="지역 검색" aria-controls="regionAutocomplete"
	                    aria-expanded="false">
	
	                <div id="regionAutocomplete" class="autocompleteList"
	                    role="listbox" hidden></div>
	            </div>
	
	            <button type="button" id="regionSearchBtn">지역 검색</button>
	        </div>
	
	        <!-- 새 카카오 장소 검색 -->
	        <div class="placeSearch">
	            <input type="text" id="placeSearchInput"
	                placeholder="장소, 음식점, 관광지 검색" autocomplete="off"
	                aria-label="장소 검색">
	
	            <button type="button" id="placeSearchBtn">검색</button>
	        </div>
	
	        <!-- 장소 검색 결과 -->
	        <div id="placeSearchResults"></div>
	
	    </div>
	
	    <!-- 카카오맵은 이 요소에만 표시 -->
	    <div id="map" class="mapContainer"></div>
	
	</div>
	
	</div>
</div>
<script>



(function () {

    // 1. 지도 기본 설정
    const container = document.getElementById("map");
    const status = document.getElementById("mapStatus");
    const districtsBtn = document.getElementById("showDistrictsBtn");

    if (typeof kakao === "undefined" || !kakao.maps) {
        status.textContent =
            "카카오 지도 SDK를 불러오지 못했습니다. API 키를 확인해 주세요.";
        return;
    }

    const centerPosition = new kakao.maps.LatLng(36.5, 127.8);

    const map = new kakao.maps.Map(container, {
        center: centerPosition,
        level: 13,
        clickable: true
    });

    // 2. GeoJSON 행정구역 데이터 주소
    const GEOJSON_URL =
        "https://raw.githubusercontent.com/KnellBalm/kr-admin-geojson/main/ctprvn.geojson";
    // 시·군·구 경계선 데이터
    const DISTRICT_GEOJSON_URL =
        "https://raw.githubusercontent.com/KnellBalm/kr-admin-geojson/main/sig.geojson";

    // 3. 생성한 경계선 객체 보관
    const regionPolygons = [];

    // 현재 선택한 지역
    let selectedRegion = null;
    
 	// 장소 검색에 적용할 지역
    let currentSearchRegion = "";

    // 시·군·구 경계선 객체 보관
    const districtPolygons = [];

    // 현재 표시 중인 시·군·구 지역
    let currentDistrictRegion = null;

    // 시·군·구 데이터 캐시
    let districtGeoJSON = null;
    let districtGeoJSONPromise = null;


    // 4. 기본 경계선 디자인
    const normalStyle = {
        strokeWeight: 2,
        strokeColor: "#2563eb",
        strokeOpacity: 0.9,
        fillColor: "#93c5fd",
        fillOpacity: 0.15
    };

    // 5. 선택한 지역의 경계선 디자인
    const selectedStyle = {
        strokeWeight: 4,
        strokeColor: "#ea580c",
        strokeOpacity: 1,
        fillColor: "#fb923c",
        fillOpacity: 0.4
    };

    // 6. GeoJSON 좌표를 카카오맵 좌표로 변환
    function convertCoordinates(ring) {
        return ring.map(function (coordinate) {
            const longitude = coordinate[0];
            const latitude = coordinate[1];

            return new kakao.maps.LatLng(latitude, longitude);
        });
    }

    // 7. 전국 경계선을 기본 스타일로 변경
    function resetPolygonStyles() {

        // 시·도 경계선 초기화
        regionPolygons.forEach(function (region) {
            region.polygons.forEach(function (polygon) {
                polygon.setOptions(normalStyle);
            });
        });

        // 시·군·구 경계선 제거
        districtPolygons.forEach(function (polygon) {
            polygon.setMap(null);
        });

        districtPolygons.length = 0;

        selectedRegion = null;
        currentDistrictRegion = null;

        districtsBtn.disabled = true;
    }

    // 지도 전체 초기화
		function resetMap() {
		
		    // 기존 경계선의 선택 스타일 및 시·군·구 상태 초기화
		    resetPolygonStyles();
		
		    // 제거했던 시·도 경계선을 다시 표시
		    regionPolygons.forEach(function (region) {
		        region.polygons.forEach(function (polygon) {
		            polygon.setMap(map);
		            polygon.setOptions(normalStyle);
		        });
		    });
		
		    map.setCenter(centerPosition);
		    map.setLevel(13);
		
		    document.getElementById("regionSearchInput").value = "";
		    document.getElementById("placeSearchInput").value = "";
		    closeAutocomplete();
		    
		    clearTimeout(placeAutocompleteTimer);
		    placeAutocompleteRequestId++;
		    
			document.getElementById("placeSearchResults").replaceChildren();
	
			clearSearchMarkers();
			currentSearchRegion = "";
			status.textContent = "전국 지도로 초기화했습니다.";
		}
		
		// 일반 카카오맵 모드로 전환
		function switchToNormalMap(bounds, regionName) {
		
		    // 선택한 지역으로 먼저 이동
		    map.setBounds(bounds);
		
		    // 전국 시·도 경계선 제거
		    regionPolygons.forEach(function (region) {
		        region.polygons.forEach(function (polygon) {
		            polygon.setMap(null);
		        });
		    });
		
		    // 시·군·구 경계선 제거
		    districtPolygons.forEach(function (polygon) {
		        polygon.setMap(null);
		    });
		
		    districtPolygons.length = 0;
		
		    // 행정구역 선택 상태 해제
		    selectedRegion = null;
		    currentDistrictRegion = null;
		    districtsBtn.disabled = true;
		    
		    currentSearchRegion = regionName;
		
		    status.textContent =
		        regionName + " 지도로 이동했습니다. 장소를 검색해 보세요.";
		}


    // 시·도 선택
    function selectRegion(region) {
	
    	// 숨겨진 시·도 경계선 다시 표시
    	regionPolygons.forEach(function (item) {
    	    item.polygons.forEach(function (polygon) {
    	        polygon.setMap(map);
    	    });
    	});
    	
        // 1. 기존 시·도 선택 스타일 초기화
        regionPolygons.forEach(function (item) {
            item.polygons.forEach(function (polygon) {
                polygon.setOptions(normalStyle);
            });
        });

        // 2. 기존 시·군·구 경계선 모두 제거
        districtPolygons.forEach(function (polygon) {
            polygon.setMap(null);
        });

        districtPolygons.length = 0;

        // 3. 시·군·구 선택 정보 초기화
        currentDistrictRegion = null;

        // 4. 새로 선택한 시·도 저장
        selectedRegion = region;
        
        currentSearchRegion = region.name;

        // 5. 선택한 시·도 강조
        region.polygons.forEach(function (polygon) {
            polygon.setOptions(selectedStyle);
        });

        // 6. 선택한 시·도 영역 계산
        const bounds = new kakao.maps.LatLngBounds();

        region.polygons.forEach(function (polygon) {

            const paths = polygon.getPath();

            paths.forEach(function (path) {
                path.forEach(function (position) {
                    bounds.extend(position);
                });
            });
        });

        // 7. 선택한 시·도로 지도 이동 및 확대
        map.setBounds(bounds);

        // 8. 시·군·구 버튼 활성화
        districtsBtn.disabled = false;

        // 9. 상태 메시지 갱신
        status.textContent =
            region.name + "을(를) 선택했습니다.";
    }

    // 시·도 경계선 그리기
    function drawRegion(feature) {

        const geometry = feature.geometry;
        const properties = feature.properties || {};

        if (!geometry) {
            return;
        }

        let polygonGroups;

        if (geometry.type === "Polygon") {
            polygonGroups = [geometry.coordinates];
        } else if (geometry.type === "MultiPolygon") {
            polygonGroups = geometry.coordinates;
        } else {
            return;
        }

        const region = {
            name: properties.CTP_KOR_NM,
            polygons: []
        };

        polygonGroups.forEach(function (polygonCoordinates) {

            const paths = polygonCoordinates.map(function (ring) {
                return convertCoordinates(ring);
            });

            const polygon = new kakao.maps.Polygon({
                map: map,
                path: paths,
                strokeWeight: normalStyle.strokeWeight,
                strokeColor: normalStyle.strokeColor,
                strokeOpacity: normalStyle.strokeOpacity,
                fillColor: normalStyle.fillColor,
                fillOpacity: normalStyle.fillOpacity
            });

            region.polygons.push(polygon);

            kakao.maps.event.addListener(
                polygon,
                "click",
                function () {
                    selectRegion(region);
                }
            );
        });

        regionPolygons.push(region);
    }

    // 9. GeoJSON의 Polygon / MultiPolygon 처리
    function drawDistrict(feature) {

        const geometry = feature.geometry;
        const properties = feature.properties || {};

        // 선택한 시·도에 속한 구역인지 확인
        if (!selectedRegion ||
            properties.SIDO_NM !== selectedRegion.name) {
            return;
        }

        if (!geometry) {
            return;
        }

        let polygonGroups;

        if (geometry.type === "Polygon") {
            polygonGroups = [geometry.coordinates];
        } else if (geometry.type === "MultiPolygon") {
            polygonGroups = geometry.coordinates;
        } else {
            return;
        }

        polygonGroups.forEach(function (polygonCoordinates) {

            const paths = polygonCoordinates.map(function (ring) {
                return convertCoordinates(ring);
            });

            const polygon = new kakao.maps.Polygon({
                map: map,
                path: paths,
                strokeWeight: 1,
                strokeColor: "#475569",
                strokeOpacity: 0.9,
                fillColor: "#bfdbfe",
                fillOpacity: 0.12
            });

            // 해당 경계선의 전체 지역명 저장
            polygon.__fullName = properties.FULL_NM;

            districtPolygons.push(polygon);

	         // 시·군·구 클릭 시 일반 카카오맵 모드로 전환
	            kakao.maps.event.addListener(
	                polygon,
	                "click",
	                function () {
	
	                    // 클릭한 시·군·구의 지도 범위 계산
	                    const bounds = new kakao.maps.LatLngBounds();
	
	                    paths.forEach(function (path) {
	                        path.forEach(function (position) {
	                            bounds.extend(position);
	                        });
	                    });
	
	                    // 경계선을 제거하고 일반 지도 모드로 전환
	                    switchToNormalMap(bounds, properties.FULL_NM);
	                }
            );
        });
    }

    function loadDistrictData() {

        // 이미 데이터가 있으면 재사용
        if (districtGeoJSON) {
            return Promise.resolve(districtGeoJSON);
        }

        // 이미 요청 중이면 같은 요청을 재사용
        if (districtGeoJSONPromise) {
            return districtGeoJSONPromise;
        }

        districtGeoJSONPromise = fetch(DISTRICT_GEOJSON_URL)
            .then(function (response) {

                if (!response.ok) {
                    throw new Error("시·군·구 데이터 요청 실패");
                }

                return response.json();
            })
            .then(function (geojson) {

                if (!geojson.features ||
                    !Array.isArray(geojson.features)) {
                    throw new Error("시·군·구 데이터 형식이 올바르지 않습니다.");
                }

                districtGeoJSON = geojson;

                return geojson;
            })
            .catch(function (error) {

                // 실패하면 다음에 다시 요청할 수 있도록 초기화
                districtGeoJSONPromise = null;

                throw error;
            });

        return districtGeoJSONPromise;
    }

    // 11. GeoJSON 데이터 불러오기
    fetch(GEOJSON_URL)
        .then(function (response) {

            if (!response.ok) {
                throw new Error(
                    "행정구역 데이터 요청 실패: " + response.status
                );
            }

            return response.json();
        })
        .then(function (geojson) {

            if (!geojson.features ||
                !Array.isArray(geojson.features)) {
                throw new Error("GeoJSON 데이터 형식이 올바르지 않습니다.");
            }

            geojson.features.forEach(function (feature) {
                drawRegion(feature);
            });

            status.textContent =
                "전국 시·도 경계선을 불러왔습니다. 지역을 클릭해 보세요.";

        })
        .catch(function (error) {

            console.error("행정구역 데이터 로딩 오류:", error);

            status.textContent =
                "경계선 데이터를 불러오지 못했습니다. 네트워크와 데이터 주소를 확인해 주세요.";
        });

    // 12. 전국 보기
    document.getElementById("showProvincesBtn")
        .addEventListener("click", resetMap);

    // 13. 지도 초기화
    document.getElementById("resetMapBtn")
        .addEventListener("click", resetMap);

    // 시·군·구 경계선 표시
	districtsBtn.addEventListener("click", function () {

	    if (!selectedRegion) {
	        status.textContent = "먼저 시·도를 선택해 주세요.";
	        return;
	    }
	
	    // 비동기 요청이 끝날 때까지 비교할 지역명 저장
	    const regionName = selectedRegion.name;
	
	    districtPolygons.forEach(function (polygon) {
	        polygon.setMap(null);
	    });
	
	    districtPolygons.length = 0;
	    currentDistrictRegion = null;
	
	    status.textContent =
	        regionName + " 시·군·구 데이터를 불러오는 중입니다.";
	
	    loadDistrictData()
	        .then(function (geojson) {
	
	            // 데이터를 기다리는 동안 다른 시·도를 선택했는지 확인
	            if (!selectedRegion ||
	                selectedRegion.name !== regionName) {
	                return;
	            }
	
	            geojson.features.forEach(function (feature) {
	                drawDistrict(feature);
	            });
	
	            status.textContent =
	                regionName + " 시·군·구 경계선을 표시했습니다.";
	        })
	        .catch(function (error) {
	
	            console.error(error);
	
	            status.textContent =
	                "시·군·구 데이터를 불러오지 못했습니다.";
	        });
	});

    // 지역 검색
    function searchRegion() {

        const input = document.getElementById("regionSearchInput");
        const keyword = input.value.trim();

        if (!keyword) {
            status.textContent = "검색할 지역명을 입력해 주세요.";
            input.focus();
            return;
        }

        // 1. 시·도 이름부터 검색
        const province = regionPolygons.find(function (region) {
            return region.name === keyword;
        }) || regionPolygons.find(function (region) {
            return region.name.includes(keyword);
        });

        if (province) {
            selectRegion(province);

            status.textContent =
                province.name + "을(를) 검색했습니다.";

            return;
        }

        // 2. 시·군·구 데이터에서 검색
        status.textContent = "지역을 검색하고 있습니다.";

        loadDistrictData()
            .then(function (geojson) {

                const features = geojson.features;

                // 전체 지역명 완전 일치 우선
                let target = features.find(function (feature) {
                    const properties = feature.properties || {};

                    return properties.FULL_NM === keyword ||
                        properties.SIG_KOR_NM === keyword;
                });

                // 완전 일치가 없으면 부분 일치 검색
                if (!target) {
                    target = features.find(function (feature) {
                        const properties = feature.properties || {};

                        return properties.FULL_NM &&
                            properties.FULL_NM.includes(keyword);
                    });
                }

                if (!target) {
                    status.textContent =
                        "검색 결과가 없습니다. 지역명을 확인해 주세요.";
                    return;
                }

                const properties = target.properties;

             // 검색된 시·군·구의 경계 좌표로 지도 범위 계산
                const geometry = target.geometry;

                if (!geometry) {
                    status.textContent = "해당 지역의 지도 정보를 찾을 수 없습니다.";
                    return;
                }

                let polygonGroups;

                if (geometry.type === "Polygon") {
                    polygonGroups = [geometry.coordinates];
                } else if (geometry.type === "MultiPolygon") {
                    polygonGroups = geometry.coordinates;
                } else {
                    status.textContent = "지원하지 않는 지역 경계 형식입니다.";
                    return;
                }

                const bounds = new kakao.maps.LatLngBounds();

                polygonGroups.forEach(function (polygonCoordinates) {
                    polygonCoordinates.forEach(function (ring) {
                        ring.forEach(function (coordinate) {
                            bounds.extend(
                                new kakao.maps.LatLng(
                                    coordinate[1],
                                    coordinate[0]
                                )
                            );
                        });
                    });
                });

                // 검색 결과 지역으로 이동한 뒤 일반 지도 모드로 전환
                switchToNormalMap(bounds, properties.FULL_NM);

            })
            .catch(function (error) {

                console.error("지역 검색 오류:", error);

                status.textContent =
                    "지역 검색에 실패했습니다. 네트워크를 확인해 주세요.";
            });
    }

    // 검색 버튼 클릭
    document.getElementById("regionSearchBtn").addEventListener("click", searchRegion);

    const searchInput = document.getElementById("regionSearchInput");
    const autocompleteList = document.getElementById("regionAutocomplete");

    let autocompleteItems = [];
    let activeAutocompleteIndex = -1;

    // 자동완성 목록 표시
    function renderAutocomplete(keyword) {

        autocompleteList.replaceChildren();
        autocompleteItems = [];
        activeAutocompleteIndex = -1;

        if (!keyword) {
            closeAutocomplete();
            return;
        }

        const candidates = [];

        // 1. 시·도 후보 추가
        regionPolygons.forEach(function (region) {

            if (region.name.includes(keyword)) {
                candidates.push({
                    name: region.name,
                    fullName: region.name,
                    type: "시·도",
                    priority: region.name === keyword ? 0 : 1
                });
            }
        });

        // 2. 시·군·구 후보 추가
        if (districtGeoJSON && Array.isArray(districtGeoJSON.features)) {

            districtGeoJSON.features.forEach(function (feature) {

                const properties = feature.properties || {};
                const name = properties.SIG_KOR_NM;
                const fullName = properties.FULL_NM;

                if (!name || !fullName) {
                    return;
                }

                // 지역명 또는 전체 지역명에 검색어가 포함되는지 확인
                if (name.includes(keyword) || fullName.includes(keyword)) {

                    candidates.push({
                        name: name,
                        fullName: fullName,
                        type: "시·군·구",
                        priority:
                            fullName === keyword ? 0 :
                            name === keyword ? 1 :
                            name.startsWith(keyword) ? 2 : 3
                    });
                }
            });
        }

        // 우선순위 정렬 후 중복 제거
        candidates.sort(function (a, b) {
            return a.priority - b.priority ||
                a.fullName.localeCompare(b.fullName, "ko");
        });

        const uniqueCandidates = [];
        const seen = new Set();

        candidates.forEach(function (candidate) {
            if (!seen.has(candidate.fullName)) {
                seen.add(candidate.fullName);
                uniqueCandidates.push(candidate);
            }
        });

        // 최대 8개까지만 표시
        autocompleteItems = uniqueCandidates.slice(0, 8);

        if (autocompleteItems.length === 0) {

            const emptyMessage = document.createElement("div");
            emptyMessage.className = "autocompleteEmpty";
            emptyMessage.textContent = "검색 결과가 없습니다.";

            autocompleteList.appendChild(emptyMessage);
            openAutocomplete();
            return;
        }

        autocompleteItems.forEach(function (item, index) {

            const button = document.createElement("button");
            button.type = "button";
            button.setAttribute("role", "option");
            button.setAttribute("aria-selected", "false");
            button.className = "autocompleteItem";

            const nameElement = document.createElement("span");
            nameElement.className = "autocompleteName";
            nameElement.textContent = item.fullName;

            const typeElement = document.createElement("span");
            typeElement.className = "autocompleteType";
            typeElement.textContent = item.type;

            button.appendChild(nameElement);
            button.appendChild(typeElement);

            // 후보를 클릭하면 해당 지역 검색
            button.addEventListener("click", function () {
                selectAutocompleteItem(index);
            });

            autocompleteList.appendChild(button);
        });

        openAutocomplete();
    }

    // 자동완성 목록 열기
    function openAutocomplete() {
        autocompleteList.hidden = false;
        searchInput.setAttribute("aria-expanded", "true");
    }

    // 자동완성 목록 닫기
    function closeAutocomplete() {
        autocompleteList.hidden = true;
        searchInput.setAttribute("aria-expanded", "false");
        activeAutocompleteIndex = -1;
    }

    // 키보드로 현재 선택된 후보 강조
    function updateActiveAutocomplete() {

        const buttons = autocompleteList.querySelectorAll(
            ".autocompleteItem"
        );

        buttons.forEach(function (button, index) {

            const isActive = index === activeAutocompleteIndex;

            button.classList.toggle("active", isActive);
            button.setAttribute("aria-selected", String(isActive));
        });

        if (activeAutocompleteIndex >= 0 &&
            buttons[activeAutocompleteIndex]) {

            buttons[activeAutocompleteIndex].scrollIntoView({
                block: "nearest"
            });
        }
    }

    // 후보 선택 후 기존 검색 기능 실행
    function selectAutocompleteItem(index) {

        const item = autocompleteItems[index];

        if (!item) {
            return;
        }

        searchInput.value = item.fullName;

        closeAutocomplete();

        // 기존에 구현한 지역 검색 함수 재사용
        searchRegion();
    }

    // 검색어 입력 시 자동완성 갱신
    searchInput.addEventListener("input", function () {

        const keyword = searchInput.value.trim();

        renderAutocomplete(keyword);

        // 시·군·구 데이터가 아직 없으면 불러온 뒤 후보 갱신
        if (keyword && !districtGeoJSON) {

            loadDistrictData()
                .then(function () {

                    // 사용자가 그사이에 다른 검색어를 입력했을 수도 있음
                    const currentKeyword = searchInput.value.trim();

                    if (currentKeyword) {
                        renderAutocomplete(currentKeyword);
                    }
                })
                .catch(function (error) {
                    console.error("자동완성 데이터 로딩 오류:", error);
                });
        }
    });

    // 키보드 조작
    searchInput.addEventListener("keydown", function (event) {

        // 아래쪽 화살표
        if (event.key === "ArrowDown") {

            if (autocompleteList.hidden) {
                renderAutocomplete(searchInput.value.trim());
            }

            if (autocompleteItems.length > 0) {
                event.preventDefault();

                activeAutocompleteIndex =
                    (activeAutocompleteIndex + 1) %
                    autocompleteItems.length;

                updateActiveAutocomplete();
            }

            return;
        }

        // 위쪽 화살표
        if (event.key === "ArrowUp") {

            if (autocompleteItems.length > 0 &&
                !autocompleteList.hidden) {

                event.preventDefault();

                activeAutocompleteIndex =
                    activeAutocompleteIndex <= 0
                        ? autocompleteItems.length - 1
                        : activeAutocompleteIndex - 1;

                updateActiveAutocomplete();
            }

            return;
        }

        // Enter: 선택된 후보가 있으면 해당 후보 검색
        if (event.key === "Enter") {

            event.preventDefault();

            if (!autocompleteList.hidden &&
                activeAutocompleteIndex >= 0) {

                selectAutocompleteItem(activeAutocompleteIndex);

            } else {
                closeAutocomplete();
                searchRegion();
            }

            return;
        }

        // Escape: 자동완성 닫기
        if (event.key === "Escape") {
            closeAutocomplete();
        }
    });

    // 검색창 밖을 클릭하면 자동완성 닫기
    document.addEventListener("click", function (event) {

        if (!event.target.closest(".searchInputWrap")) {
            closeAutocomplete();
        }
    });
	
	 	// 카카오 장소 검색 객체
	    const places = new kakao.maps.services.Places();
	
	    // 검색으로 생성한 마커 보관
	    const searchMarkers = [];
		

	    // 장소 자동완성 요청 관리
	    let placeAutocompleteTimer = null;
	    let placeAutocompleteRequestId = 0;

	    // 장소 연관 검색
	    function searchPlaceSuggestions() {
	    	
	        const input = document.getElementById("placeSearchInput");
	        const resultBox = document.getElementById("placeSearchResults");
	        const keyword = input.value.trim();

	        // 이전 검색 예약 취소
	        clearTimeout(placeAutocompleteTimer);

	        // 이전에 시작한 검색 결과는 무효 처리
	        placeAutocompleteRequestId++;

	        const requestId = placeAutocompleteRequestId;

	        // 입력 내용이 없으면 목록 제거
	        if (!keyword) {
	            resultBox.replaceChildren();
	            return;
	        }

	        // 너무 잦은 API 호출을 방지하기 위해 잠시 대기
	        placeAutocompleteTimer = setTimeout(function () {
	            resultBox.replaceChildren();

	            const message = document.createElement("div");
	            message.className = "placeAutocompleteMessage";
	            message.textContent = "연관 장소를 검색하고 있습니다.";
	            resultBox.appendChild(message);
	            
	            const searchKeyword = currentSearchRegion
	            ? currentSearchRegion + " " + keyword
	            : keyword;

	        	places.keywordSearch(searchKeyword, function(data, searchStatus) {

	                // 더 최근에 입력한 검색어가 있으면 이전 결과 무시
	                if (requestId !== placeAutocompleteRequestId) {
	                    return;
	                }

	                resultBox.replaceChildren();

	                if (searchStatus !== kakao.maps.services.Status.OK) {
	                    const emptyMessage = document.createElement("div");
	                    emptyMessage.className = "placeAutocompleteMessage";
	                    emptyMessage.textContent = "연관 검색 결과가 없습니다.";
	                    resultBox.appendChild(emptyMessage);
	                    return;
	                }

	                // 최대 5개 표시
	                data.slice(0, 5).forEach(function (place) {
	                    const item = document.createElement("button");
	                    item.type = "button";
	                    item.className = "placeAutocompleteItem";

	                    const name = document.createElement("strong");
	                    name.textContent = place.place_name;

	                    const address = document.createElement("span");
	                    address.textContent =
	                        place.road_address_name ||
	                        place.address_name ||
	                        "주소 정보 없음";

	                    item.appendChild(name);
	                    item.appendChild(address);

	                    // 연관 검색 항목 선택
	                    item.addEventListener("click", function () {
	                        input.value = place.place_name;

	                        // 진행 중인 자동완성 결과 무효 처리
	                        clearTimeout(placeAutocompleteTimer);
	                        placeAutocompleteRequestId++;

	                        resultBox.replaceChildren();

	                        // 기존 마커 제거
	                        clearSearchMarkers();

	                        const position = new kakao.maps.LatLng(
	                            Number(place.y),
	                            Number(place.x)
	                        );

	                        // 선택한 장소에 마커 표시
	                        const marker = new kakao.maps.Marker({
	                            map: map,
	                            position: position,
	                            title: place.place_name
	                        });

	                        searchMarkers.push(marker);

	                        // 선택한 장소로 이동
	                        map.setCenter(position);
	                        map.setLevel(3);

	                        // 장소 정보창 표시
	                        const content =
	                            '<div style="padding:10px; max-width:240px;">' +
	                                '<strong>' +
	                                    escapeHtml(place.place_name) +
	                                '</strong>' +
	                                '<div style="margin-top:5px; font-size:12px;">' +
	                                    escapeHtml(
	                                        place.road_address_name ||
	                                        place.address_name ||
	                                        "주소 정보 없음"
	                                    ) +
	                                '</div>' +
	                                '<div style="margin-top:5px;">' +
	                                    '<a href="' +
	                                        escapeHtml(place.place_url) +
	                                        '" target="_blank" rel="noopener noreferrer">' +
	                                        '카카오맵에서 보기' +
	                                    '</a>' +
	                                '</div>' +
	                            '</div>';

	                        searchInfoWindow.setContent(content);
	                        searchInfoWindow.open(map, marker);

	                        // 마커를 클릭해도 정보창 표시
	                        kakao.maps.event.addListener(marker, "click", function () {
	                            searchInfoWindow.open(map, marker);
	                        });

	                        status.textContent =
	                            place.place_name + "을(를) 선택했습니다.";
	                    });

	                    resultBox.appendChild(item);
	                });
	            });
	        }, 300);
	    }

	    
	    // 장소 정보창
	    const searchInfoWindow = new kakao.maps.InfoWindow({
	        removable: true
	    });
	
	    // 검색 결과 마커 제거
	    function clearSearchMarkers() {
	        searchMarkers.forEach(function(marker) {
	            marker.setMap(null);
	        });
	
	        searchMarkers.length = 0;
	        searchInfoWindow.close();
	    }
	
	    // 검색 결과를 HTML에 넣기 전 문자열 처리
	    function escapeHtml(value) {
	        return String(value ?? "").replace(/[&<>"']/g, function(char) {
	            return {
	                "&": "&amp;",
	                "<": "&lt;",
	                ">": "&gt;",
	                '"': "&quot;",
	                "'": "&#39;"
	            }[char];
	        });
	    }
	
	    // 장소 검색
	    function searchPlaces() {
	        const input = document.getElementById("placeSearchInput");
	        const resultBox = document.getElementById("placeSearchResults");
	        const keyword = input.value.trim();
	
	        if (!keyword) {
	            status.textContent = "검색할 장소명을 입력해 주세요.";
	            input.focus();
	            return;
	        }
	
	        clearSearchMarkers();
	        resultBox.replaceChildren();
	
	     // 선택한 지역이 있으면 검색어 앞에 지역명을 추가
	        const searchKeyword = currentSearchRegion
	            ? currentSearchRegion + " " + keyword
	            : keyword;

	        places.keywordSearch(searchKeyword, function(data, searchStatus) {
	
	            if (searchStatus === kakao.maps.services.Status.ZERO_RESULT) {
	                resultBox.textContent = "검색 결과가 없습니다.";
	                status.textContent = "검색 결과가 없습니다.";
	                return;
	            }
	
	            if (searchStatus !== kakao.maps.services.Status.OK) {
	                resultBox.textContent = "장소 검색에 실패했습니다.";
	                status.textContent = "장소 검색에 실패했습니다.";
	                return;
	            }
	
	            const bounds = new kakao.maps.LatLngBounds();
	
	            data.forEach(function(place) {
	                const position = new kakao.maps.LatLng(
	                    Number(place.y),
	                    Number(place.x)
	                );
	
	                // 마커 생성
	                const marker = new kakao.maps.Marker({
	                    map: map,
	                    position: position,
	                    title: place.place_name
	                });
	
	                searchMarkers.push(marker);
	                bounds.extend(position);
	
	                // 검색 결과 항목 생성
	                const item = document.createElement("div");
	                item.className = "placeSearchResult";
	
	                const name = document.createElement("strong");
	                name.textContent = place.place_name;
	
	                const address = document.createElement("span");
	                address.textContent =
	                    place.road_address_name ||
	                    place.address_name ||
	                    "주소 정보 없음";
	
	                item.appendChild(name);
	                item.appendChild(address);
	
	                // 장소 선택 시 지도 이동 및 정보 표시
	                function selectPlace() {
	                    map.setCenter(position);
	                    map.setLevel(3);
	
	                    const content =
	                        '<div style="padding:10px; max-width:240px;">' +
	                            '<strong>' +
	                                escapeHtml(place.place_name) +
	                            '</strong>' +
	                            '<div style="margin-top:5px; font-size:12px;">' +
	                                escapeHtml(
	                                    place.road_address_name ||
	                                    place.address_name ||
	                                    "주소 정보 없음"
	                                ) +
	                            '</div>' +
	                            '<div style="margin-top:5px;">' +
	                                '<a href="' +
	                                    escapeHtml(place.place_url) +
	                                    '" target="_blank" rel="noopener noreferrer">' +
	                                    '카카오맵에서 보기' +
	                                '</a>' +
	                            '</div>' +
	                        '</div>';
	
	                    searchInfoWindow.setContent(content);
	                    searchInfoWindow.open(map, marker);
	                }
	
	                item.addEventListener("click", selectPlace);
	
	                kakao.maps.event.addListener(
	                    marker,
	                    "click",
	                    selectPlace
	                );
	
	                resultBox.appendChild(item);
	            });
	
	            // 검색된 장소들이 지도에 보이도록 범위 조정
	            map.setBounds(bounds);
	
	            status.textContent =
	                "'" + keyword + "' 검색 결과 " + data.length + "개를 표시했습니다.";
	        });
	    }
	
	    // 검색 버튼 클릭
	    document.getElementById("placeSearchBtn")
	        .addEventListener("click", searchPlaces);
	    
		// 입력할 때마다 장소 연관 검색
	    document.getElementById("placeSearchInput")
	        .addEventListener("input", searchPlaceSuggestions);
	
	    // Enter 키 검색
	    document.getElementById("placeSearchInput")
	        .addEventListener("keydown", function(event) {
	            if (event.key === "Enter") {
	                searchPlaces();
	            }
	        });
   

})();

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>